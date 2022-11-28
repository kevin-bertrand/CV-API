//
//  UserController.swift
//  
//
//  Created by Kevin Bertrand on 10/10/2022.
//

import Fluent
import Vapor

struct UserController: RouteCollection {
    // MARK: Properties
    
    // MARK: Route initialisation
    func boot(routes: RoutesBuilder) throws {
        let userGroup = routes.grouped("user")
        
        let basicGroup = userGroup.grouped(User.authenticator()).grouped(User.guardMiddleware())
        basicGroup.post("login", use: login)
    }
    
    // MARK: Routes functions
    /// Login
    private func login(req: Request) async throws -> Response {
        let userAuth = try GlobalFunctions.shared.getUserAuthFor(req)
        
        let token = try await generateToken(for: userAuth, in: req)
        
        return GlobalFunctions.shared.formatResponse(status: .ok, body: .init(string: token.value))
    }
    
    // MARK: Utilities functions
    /// Generate token when login is success
    private func generateToken(for user: User, in req: Request) async throws -> UserToken {
        let token = try user.generateToken()
        try await token.save(on: req.db)
        return token
    }
}

