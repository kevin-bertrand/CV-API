//
//  CreateTraining.swift
//  
//
//  Created by Kevin Bertrand on 07/10/2022.
//

import Fluent
import Vapor

struct CreateTraining: AsyncMigration {
    // Create DB
    func prepare(on database: Database) async throws {
        try await database.schema(NameManager.Training.schema.rawValue)
            .id()
            .field(NameManager.Training.title.rawValue.fieldKey, .string, .required)
            .field(NameManager.Training.organization.rawValue.fieldKey, .string, .required)
            .field(NameManager.Training.date.rawValue.fieldKey, .date, .required)
            .field(NameManager.Training.documentPath.rawValue.fieldKey, .string, .required)
            .field(NameManager.Training.icon.rawValue.fieldKey, .string, .required)
            .create()
    }
    
    // Delete DB
    func revert(on database: Database) async throws {
        try await database.schema(NameManager.Training.schema.rawValue).delete()
    }
}
