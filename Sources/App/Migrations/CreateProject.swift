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
        let category = try await database.enum("project_categories").read()
        
        try await database.schema(Project.schema)
            .id()
            .field("title", .string, .required)
            .field("media_path", .string, .required)
            .field("description", .string, .required)
            .field("company", .string, .required)
            .field("date", .date, .required)
            .field("github", .string)
            .field("category", category, .required)
            .create()
    }
    
    // Delete DB
    func revert(on database: Database) async throws {
        try await database.schema(Project.schema).delete()
    }
}
