//
//  EducationController.swift
//  
//
//  Created by Kevin Bertrand on 10/10/2022.
//

import Fluent
import Vapor

struct EducationController: RouteCollection {
    // MARK: Properties
    
    // MARK: Route initialisation
    func boot(routes: RoutesBuilder) throws {
        let educationGroup = routes.grouped("education")
        educationGroup.get(use: get)
        
        let tokenGroup = educationGroup.grouped(UserToken.authenticator()).grouped(UserToken.guardMiddleware())
        tokenGroup.post(use: create)
    }
    
    // MARK: Routes functions
    // Adding education
    private func create(req: Request) async throws -> Response {
        let serverIP = Environment.get("SERVER_HOSTNAME") ?? "127.0.0.1"
        let serverPort = Environment.get("SERVER_PORT").flatMap(Int.init(_:)) ?? 8080
        let createEducation = try req.content.decode(Education.Create.self)
        
        let education = Education(school: createEducation.school,
                                  title: createEducation.title,
                                  level: createEducation.level,
                                  location: createEducation.location,
                                  icon: createEducation.icon,
                                  endingDate: createEducation.endingDate,
                                  documentPath: createEducation.documentPath)
        
        try await education.save(on: req.db)
        
        let educationId = try await Education.query(on: req.db)
            .filter(\.$school == education.school)
            .filter(\.$location == education.location)
            .first()?
            .id
        
        guard let id = educationId else {
            throw Abort(.internalServerError)
        }
        
        for subject in createEducation.subjects {
            if let subjectUrl = subject.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                _ = try await req.client.post("http://\(serverIP):\(serverPort)/subject/\(id)/\(subjectUrl)", headers: req.headers)
            }
        }
        
        return formatResponse(status: .created, body: .empty)
    }
    
    /// Getting all educations
    private func get(req: Request) async throws -> Response {
        let educations = try await Education.query(on: req.db)
            .sort(\.$endingDate)
            .all()
        
        var educationArray = [Education.Getting]()
        
        for education in educations {
            if let educationId = education.id {
                let subjects = try await Subject.query(on: req.db).filter(\.$education.$id == educationId).all()
                
                educationArray.append(Education.Getting(school: education.school,
                                                        title: education.title,
                                                        level: education.level,
                                                        location: education.location,
                                                        icon: education.icon,
                                                        endingDate: Int(education.endingDate.timeIntervalSince1970),
                                                        documentPath: education.documentPath,
                                                        subjects: subjects.map{$0.title}))
            }
        }
        
        return formatResponse(status: .ok, body: .init(data: try JSONEncoder().encode(educationArray)))
    }
    // MARK: Utilities functions
    /// Getting the connected user
    private func getUserAuthFor(_ req: Request) throws -> User {
        return try req.auth.require(User.self)
    }
    
    /// Formating response
    private func formatResponse(status: HTTPResponseStatus, body: Response.Body) -> Response {
        var headers = HTTPHeaders()
        headers.add(name: .contentType, value: "application/json")
        return .init(status: status, headers: headers, body: body)
    }
}

