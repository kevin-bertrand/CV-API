//
//  Authenticator.swift
//  
//
//  Created by Kevin Bertrand on 10/10/2022.
//

import Fluent
import Vapor

extension User: ModelAuthenticatable {
    static var usernameKey = \User.$email
    static var passwordHashKey = \User.$passwordHash
    
    func verify(password: String) throws -> Bool {
        return try Bcrypt.verify(password, created: self.passwordHash)
    }
    
    func generateToken() throws -> UserToken {
        return try UserToken(value: [UInt8].random(count: 16).base64, userID: self.requireID())
    }
}

extension UserToken: ModelTokenAuthenticatable {
    static let valueKey = \UserToken.$value
    static let userKey = \UserToken.$user
    
    var isValid: Bool {
        true
    }
}

