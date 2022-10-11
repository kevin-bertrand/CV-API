//
//  ProjectController.swift
//  
//
//  Created by Kevin Bertrand on 11/10/2022.
//

import Fluent
import Vapor

struct ProjectController: RouteCollection {
    // MARK: Properties
    
    // MARK: Route initialisation
    func boot(routes: RoutesBuilder) throws {
        let projectGroup = routes.grouped("project")
        projectGroup.get(use: get)
        
        let tokenGroup = projectGroup.grouped(UserToken.authenticator()).grouped(UserToken.guardMiddleware())
        tokenGroup.post(use: create)
    }
    
    // MARK: Routes functions
    /// Create a project
    private func create(req: Request) async throws -> Response {
        let project = try req.content.decode(Project.self)
        try await project.save(on: req.db)
        return formatResponse(status: .created, body: .empty)
    }
    
    /// Getting all projects
    private func get(req: Request) async throws -> Response {
        let projects = try await Project.query(on: req.db)
            .sort(\.$date)
            .all()
        
        return formatResponse(status: .ok, body: .init(data: try JSONEncoder().encode(projects)))
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

