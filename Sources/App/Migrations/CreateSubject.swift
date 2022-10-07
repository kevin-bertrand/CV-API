//
//  CreateSubject.swift
//  
//
//  Created by Kevin Bertrand on 07/10/2022.
//

import Fluent
import Vapor

struct CreateSubject: AsyncMigration {
    // Create DB
    func prepare(on database: Database) async throws {
        try await database.schema(Subject.schema)
            .id()
            .field("title", .string, .required)
            .field("education_id", .uuid, .required, .references(Education.schema, "id"))
            .create()
    }
    
    // Delete DB
    func revert(on database: Database) async throws {
        try await database.schema(Subject.schema).delete()
    }
}
