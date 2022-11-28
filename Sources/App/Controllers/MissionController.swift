//
//  MissionController.swift
//  
//
//  Created by Kevin Bertrand on 11/10/2022.
//

import Fluent
import Vapor

struct MissionController: RouteCollection {
    // MARK: Properties
    
    // MARK: Route initialisation
    func boot(routes: RoutesBuilder) throws {
        let missionGroup = routes.grouped("mission")
        
        let tokenGroup = missionGroup.grouped(UserToken.authenticator()).grouped(UserToken.guardMiddleware())
        tokenGroup.post(":id", ":title", ":tasks", use: create)
    }
    
    // MARK: Routes functions
    /// Create a mission
    private func create(req: Request) async throws -> Response {
        guard let id = req.parameters.get("id", as: UUID.self),
              let title = req.parameters.get("title")?.removingPercentEncoding,
              let tasks = req.parameters.get("tasks")?.removingPercentEncoding?.replacingOccurrences(of: "\\", with: "/") else {
            throw Abort(.notAcceptable)
        }
        
        try await Mission(title: title, tasks: tasks, experienceID: id).save(on: req.db)
        return GlobalFunctions.shared.formatResponse(status: .created, body: .empty)
    }
}

