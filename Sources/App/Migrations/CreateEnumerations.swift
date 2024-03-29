//
//  CreateEnumerations.swift
//  
//
//  Created by Kevin Bertrand on 07/10/2022.
//

import Fluent
import Vapor

struct CreateEnumerations: AsyncMigration {
    // Create DB
    func prepare(on database: Database) async throws {
        _ = try await database.enum(NameManager.Enumeration.skillsCategories.rawValue)
            .case(SkillsCategories.backend.rawValue)
            .case(SkillsCategories.frontend.rawValue)
            .case(SkillsCategories.management.rawValue)
            .case(SkillsCategories.other.rawValue)
            .case(SkillsCategories.automation.rawValue)
            .create()
        
        _ = try await database.enum(NameManager.Enumeration.projectCategories.rawValue)
            .case(ProjectCategories.iOS.rawValue)
            .case(ProjectCategories.automation.rawValue)
            .create()
    }
    
    // Delete DB
    func revert(on database: Database) async throws {
        try await database.enum(NameManager.Enumeration.skillsCategories.rawValue).delete()
        try await database.enum(NameManager.Enumeration.projectCategories.rawValue).delete()
    }
}
