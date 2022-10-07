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
        try await database.schema(Experience.schema)
            .id()
            .field("title", .string, .required)
            .field("company", .string, .required)
            .field("location", .string, .required)
            .field("start_date", .date, .required)
            .field("end_date", .date)
            .create()
    }
    
    // Delete DB
    func revert(on database: Database) async throws {
        try await database.schema(Experience.schema).delete()
    }
}
