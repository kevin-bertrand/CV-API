//
//  CreateUserToken.swift
//  
//
//  Created by Kevin Bertrand on 10/10/2022.
//

import Fluent
import Vapor

struct CreateUserToken: AsyncMigration {
    // Create DB
    func prepare(on database: Database) async throws {
        try await database.schema(NameManager.UserToken.schema.rawValue)
            .id()
            .field(NameManager.UserToken.value.rawValue.fieldKey, .string, .required)
            .field(NameManager.UserToken.userId.rawValue.fieldKey, .uuid, .required, .references(NameManager.User.schema.rawValue, "id", onDelete: .cascade))
            .create()
    }
    
    // Delete DB
    func revert(on database: Database) async throws {
        try await database.schema(NameManager.UserToken.schema.rawValue).delete()
    }
}
