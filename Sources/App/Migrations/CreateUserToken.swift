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
        try await database.schema(UserToken.schema)
            .id()
            .field("value", .string, .required)
            .field("user_id", .uuid, .required, .references(User.schema, "id", onDelete: .cascade))
            .create()
    }
    
    // Delete DB
    func revert(on database: Database) async throws {
        try await database.schema(UserToken.schema).delete()
    }
}
