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
        let userAuth = try getUserAuthFor(req)
        
        let token = try await generateToken(for: userAuth, in: req)
        
        return formatResponse(status: .ok, body: .init(string: token.value))
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
    
    /// Generate token when login is success
    private func generateToken(for user: User, in req: Request) async throws -> UserToken {
        let token = try user.generateToken()
        try await token.save(on: req.db)
        return token
    }
}

