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
        let category = try await database.enum(NameManager.Enumeration.skillsCategories.rawValue).read()
        
        try await database.schema(NameManager.Skill.schema.rawValue)
            .id()
            .field(NameManager.Skill.title.rawValue.fieldKey, .string, .required)
            .field(NameManager.Skill.image.rawValue.fieldKey, .string, .required)
            .field(NameManager.Skill.category.rawValue.fieldKey, category, .required)
            .create()
    }
    
    // Delete DB
    func revert(on database: Database) async throws {
        try await database.schema(NameManager.Skill.schema.rawValue).delete()
    }
}
