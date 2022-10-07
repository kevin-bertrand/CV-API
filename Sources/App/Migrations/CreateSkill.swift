//
//  CreateSkill.swift
//  
//
//  Created by Kevin Bertrand on 07/10/2022.
//

import Fluent
import Vapor

struct CreateSkill: AsyncMigration {
    // Create DB
    func prepare(on database: Database) async throws {
        let category = try await database.enum("skills_categories").read()
        
        try await database.schema(Skill.schema)
            .id()
            .field("title", .string, .required)
            .field("image", .string, .required)
            .field("category", category, .required)
            .create()
    }
    
    // Delete DB
    func revert(on database: Database) async throws {
        try await database.schema(Skill.schema).delete()
    }
}
