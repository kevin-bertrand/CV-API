//
//  ProfileController.swift
//  
//
//  Created by Kevin Bertrand on 10/10/2022.
//

import Fluent
import Vapor

struct ProfileController: RouteCollection {
    // MARK: Properties
    
    // MARK: Route initialisation
    func boot(routes: RoutesBuilder) throws {
        let profileGroup = routes.grouped("profile")
        profileGroup.get(use: get)
        
        let tokenGroup = profileGroup.grouped(UserToken.authenticator()).grouped(UserToken.guardMiddleware())
        tokenGroup.post(use: create)
    }
    
    // MARK: Routes functions
    /// Create profile
    private func create(req: Request) async throws -> Response {
        let profile = try req.content.decode(Profile.self)
        
        try await profile.save(on: req.db)
        
        return GlobalFunctions.shared.formatResponse(status: .created, body: .empty)
    }
    
    /// Getting profile
    private func get(req: Request) async throws -> Response {
        guard let profile = try await Profile.query(on: req.db).first() else {
            throw Abort(.notFound)
        }
        
        return GlobalFunctions.shared.formatResponse(status: .ok, body: .init(data: try JSONEncoder().encode(profile)))
    }
}
