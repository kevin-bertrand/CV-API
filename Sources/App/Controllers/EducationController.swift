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
        let education = try req.content.decode(Education.self)
        try await education.save(on: req.db)
        return formatResponse(status: .created, body: .empty)
    }
    
    /// Getting all educations
    private func get(req: Request) async throws -> Response {
        let educations = try await Education.query(on: req.db)
            .sort(\.$endingDate)
            .all()
        return formatResponse(status: .ok, body: .init(data: try JSONEncoder().encode(educations)))
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

