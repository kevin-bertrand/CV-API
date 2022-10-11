//
//  CreateProject.swift
//  
//
//  Created by Kevin Bertrand on 07/10/2022.
//

import Fluent
import Vapor

struct CreateProject: AsyncMigration {
    // Create DB
    func prepare(on database: Database) async throws {
        try await database.schema(Project.schema)
            .id()
            .field("title", .string, .required)
            .field("media_path", .string, .required)
            .field("description", .string, .required)
            .field("company", .string, .required)
            .field("date", .date, .required)
            .field("github", .string)
            .create()
    }
    
    // Delete DB
    func revert(on database: Database) async throws {
        try await database.schema(Project.schema).delete()
    }
}
