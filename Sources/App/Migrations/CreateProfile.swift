//
//  CreateProfile.swift
//  
//
//  Created by Kevin Bertrand on 07/10/2022.
//

import Fluent
import Vapor

struct CreateProfile: AsyncMigration {
    // Create DB
    func prepare(on database: Database) async throws {
        try await database.schema(Profile.schema)
            .id()
            .field("firstname", .string, .required)
            .field("lastname", .string, .required)
            .field("email", .string, .required)
            .field("phone", .string, .required)
            .field("city", .string, .required)
            .field("description", .string, .required)
            .field("title", .string, .required)
            .field("github", .string, .required)
            .field("linkedin", .string, .required)
            .field("codingames", .string, .required)
            .create()
    }
    
    // Delete DB
    func revert(on database: Database) async throws {
        try await database.schema(Profile.schema).delete()
    }
}
