//
//  CreateExperience.swift
//  
//
//  Created by Kevin Bertrand on 07/10/2022.
//

import Fluent
import Vapor

struct CreateExperience: AsyncMigration {
    // Create DB
    func prepare(on database: Database) async throws {
        try await database.schema(NameManager.Experience.schema.rawValue)
            .id()
            .field(NameManager.Experience.title.rawValue.fieldKey, .string, .required)
            .field(NameManager.Experience.company.rawValue.fieldKey, .string, .required)
            .field(NameManager.Experience.location.rawValue.fieldKey, .string, .required)
            .field(NameManager.Experience.startDate.rawValue.fieldKey, .date, .required)
            .field(NameManager.Experience.endDate.rawValue.fieldKey, .date)
            .field(NameManager.Experience.icon.rawValue.fieldKey, .string, .required)
            .create()
    }
    
    // Delete DB
    func revert(on database: Database) async throws {
        try await database.schema(NameManager.Experience.schema.rawValue).delete()
    }
}
