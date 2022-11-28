//
//  SkillController.swift
//  
//
//  Created by Kevin Bertrand on 11/10/2022.
//

import Fluent
import Vapor

struct SkillController: RouteCollection {
    // MARK: Properties
    
    // MARK: Route initialisation
    func boot(routes: RoutesBuilder) throws {
        let skillGroup = routes.grouped("skill")
        skillGroup.get(use: get)
        
        let tokenGroup = skillGroup.grouped(UserToken.authenticator()).grouped(UserToken.guardMiddleware())
        tokenGroup.post(use: create)
    }
    
    // MARK: Routes functions
    /// Create skill
    private func create(req: Request) async throws -> Response {
        let skill = try req.content.decode(Skill.self)
        try await skill.save(on: req.db)
        return GlobalFunctions.shared.formatResponse(status: .created, body: .empty)
    }
    
    /// Getting all skills
    private func get(req: Request) async throws -> Response {
        let skills = try await Skill.query(on: req.db).all()
        return GlobalFunctions.shared.formatResponse(status: .ok, body: .init(data: try JSONEncoder().encode(skills)))
    }
}

