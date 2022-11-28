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
        try await database.schema(NameManager.Mission.schema.rawValue)
            .id()
            .field(NameManager.Mission.title.rawValue.fieldKey, .string, .required)
            .field(NameManager.Mission.tasks.rawValue.fieldKey, .string, .required)
            .field(NameManager.Mission.experienceId.rawValue.fieldKey, .uuid, .required, .references(NameManager.Experience.schema.rawValue, "id"))
            .create()
    }
    
    // Delete DB
    func revert(on database: Database) async throws {
        try await database.schema(NameManager.Mission.schema.rawValue).delete()
    }
}
