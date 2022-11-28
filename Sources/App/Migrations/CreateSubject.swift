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
        try await database.schema(NameManager.Subject.schema.rawValue)
            .id()
            .field(NameManager.Subject.title.rawValue.fieldKey, .string, .required)
            .field(NameManager.Subject.educationId.rawValue.fieldKey, .uuid, .required, .references(NameManager.Education.schema.rawValue, "id"))
            .create()
    }
    
    // Delete DB
    func revert(on database: Database) async throws {
        try await database.schema(NameManager.Subject.schema.rawValue).delete()
    }
}
