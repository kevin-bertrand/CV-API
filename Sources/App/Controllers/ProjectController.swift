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
        return GlobalFunctions.shared.formatResponse(status: .created, body: .empty)
    }
    
    /// Getting all projects
    private func get(req: Request) async throws -> Response {
        let projects = try await Project.query(on: req.db)
            .sort(\.$date)
            .all()
        
        var projectsArray = [Project.Getting]()
        
        for project in projects {
            projectsArray.append(Project.Getting(title: project.title,
                                                 mediaPath: project.mediaPath,
                                                 description: project.description,
                                                 company: project.company,
                                                 date: Int(project.date.timeIntervalSince1970),
                                                 github: project.github,
                                                 category: project.category))
        }
        
        return GlobalFunctions.shared.formatResponse(status: .ok, body: .init(data: try JSONEncoder().encode(projectsArray)))
    }
}

