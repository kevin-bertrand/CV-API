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
        let category = try await database.enum(NameManager.Enumeration.projectCategories.rawValue).read()
        
        try await database.schema(NameManager.Project.schema.rawValue)
            .id()
            .field(NameManager.Project.title.rawValue.fieldKey, .string, .required)
            .field(NameManager.Project.mediaPath.rawValue.fieldKey, .string, .required)
            .field(NameManager.Project.description.rawValue.fieldKey, .string, .required)
            .field(NameManager.Project.company.rawValue.fieldKey, .string, .required)
            .field(NameManager.Project.date.rawValue.fieldKey, .date, .required)
            .field(NameManager.Project.github.rawValue.fieldKey, .string)
            .field(NameManager.Project.category.rawValue.fieldKey, category, .required)
            .create()
    }
    
    // Delete DB
    func revert(on database: Database) async throws {
        try await database.schema(NameManager.Project.schema.rawValue).delete()
    }
}
