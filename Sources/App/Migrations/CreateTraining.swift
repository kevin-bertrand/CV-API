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
        try await database.schema(Training.schema)
            .id()
            .field("title", .string, .required)
            .field("organization", .string, .required)
            .field("date", .date, .required)
            .field("document_path", .string, .required)
            .create()
    }
    
    // Delete DB
    func revert(on database: Database) async throws {
        try await database.schema(Training.schema).delete()
    }
}
