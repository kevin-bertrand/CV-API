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
        tokenGroup.patch("document", ":id", ":key", use: addDocument)
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
        
        return GlobalFunctions.shared.formatResponse(status: .created, body: .empty)
    }
    
    /// Adding document to eduction
    private func addDocument(req: Request) async throws -> Response {
        guard let key = req.parameters.get("key"),
              let trainingId = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.notAcceptable)
        }
        let path = "/var/www/kevin.desyntic.com/public/docs/\(key)"
        
        _ = req.body.collect()
            .unwrap(or: Abort(.noContent))
            .flatMap { req.fileio.writeFile($0, at: path)}
        
        try await Training.query(on: req.db)
            .set(\.$documentPath, to: path)
            .filter(\.$id == trainingId)
            .update()
        
        return GlobalFunctions.shared.formatResponse(status: .ok, body: .empty)
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
                
                educationArray.append(Education.Getting(id: try education.requireID(),
                                                        school: education.school,
                                                        title: education.title,
                                                        level: education.level,
                                                        location: education.location,
                                                        icon: education.icon,
                                                        endingDate: Int(education.endingDate.timeIntervalSince1970),
                                                        documentPath: education.documentPath,
                                                        subjects: subjects.map{$0.title}))
            }
        }
        
        return GlobalFunctions.shared.formatResponse(status: .ok, body: .init(data: try JSONEncoder().encode(educationArray)))
    }
}

