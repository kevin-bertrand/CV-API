//
//  CreateMission.swift
//  
//
//  Created by Kevin Bertrand on 07/10/2022.
//

import Fluent
import Vapor

struct CreateMission: AsyncMigration {
    // Create DB
    func prepare(on database: Database) async throws {
        try await database.schema(Mission.schema)
            .id()
            .field("title", .string, .required)
            .field("tasks", .string, .required)
            .field("experience_id", .uuid, .required, .references(Experience.schema, "id"))
            .create()
    }
    
    // Delete DB
    func revert(on database: Database) async throws {
        try await database.schema(Mission.schema).delete()
    }
}
