//
//  CreateEducation.swift
//  
//
//  Created by Kevin Bertrand on 07/10/2022.
//

import Fluent
import Vapor

struct CreateEducation: AsyncMigration {
    // Create DB
    func prepare(on database: Database) async throws {
        try await database.schema(Education.schema)
            .id()
            .field("school", .string, .required)
            .field("title", .string, .required)
            .field("level", .string, .required)
            .field("location", .string, .required)
            .field("icon", .string, .required)
            .field("document_path", .string)
            .create()
    }
    
    // Delete DB
    func revert(on database: Database) async throws {
        try await database.schema(Education.schema).delete()
    }
}
