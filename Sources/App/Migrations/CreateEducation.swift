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
        try await database.schema(NameManager.Education.schema.rawValue)
            .id()
            .field(NameManager.Education.school.rawValue.fieldKey, .string, .required)
            .field(NameManager.Education.title.rawValue.fieldKey, .string, .required)
            .field(NameManager.Education.level.rawValue.fieldKey, .string, .required)
            .field(NameManager.Education.location.rawValue.fieldKey, .string, .required)
            .field(NameManager.Education.icon.rawValue.fieldKey, .string, .required)
            .field(NameManager.Education.endingDate.rawValue.fieldKey, .date, .required)
            .field(NameManager.Education.documentPath.rawValue.fieldKey, .string)
            .create()
    }
    
    // Delete DB
    func revert(on database: Database) async throws {
        try await database.schema(NameManager.Education.schema.rawValue).delete()
    }
}
