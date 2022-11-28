//
//  CreateUser.swift
//  
//
//  Created by Kevin Bertrand on 10/10/2022.
//

import Fluent
import Vapor

struct CreateUser: AsyncMigration {
    // Create DB
    func prepare(on database: Database) async throws {
        try await database.schema(NameManager.User.schema.rawValue)
            .id()
            .field(NameManager.User.email.rawValue.fieldKey, .string, .required)
            .field(NameManager.User.passwordHash.rawValue.fieldKey, .string, .required)
            .create()
    }
    
    // Delete DB
    func revert(on database: Database) async throws {
        try await database.schema(NameManager.User.schema.rawValue).delete()
    }
}
