//
//  SubjectController.swift
//  
//
//  Created by Kevin Bertrand on 10/10/2022.
//

import Fluent
import Vapor

struct SubjectController: RouteCollection {
    // MARK: Properties
    
    // MARK: Route initialisation
    func boot(routes: RoutesBuilder) throws {
        let subjectGroup = routes.grouped("subject")
                
        let tokenGroup = subjectGroup.grouped(UserToken.authenticator()).grouped(UserToken.guardMiddleware())
        tokenGroup.post(":id", ":subject", use: create)
    }
    
    // MARK: Routes functions
    /// Create a subject
    private func create(req: Request) async throws -> Response {
        guard let id = req.parameters.get("id", as: UUID.self), let subject = req.parameters.get("subject")?.removingPercentEncoding else {
            throw Abort(.notAcceptable)
        }
        
        try await Subject(title: subject, educationID: id).save(on: req.db)
        return formatResponse(status: .created, body: .empty)
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

