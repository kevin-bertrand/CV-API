//
//  CreateProfile.swift
//  
//
//  Created by Kevin Bertrand on 07/10/2022.
//

import Fluent
import Vapor

struct CreateProfile: AsyncMigration {
    // Create DB
    func prepare(on database: Database) async throws {
        try await database.schema(NameManager.Profile.schema.rawValue)
            .id()
            .field(NameManager.Profile.firstname.rawValue.fieldKey, .string, .required)
            .field(NameManager.Profile.lastname.rawValue.fieldKey, .string, .required)
            .field(NameManager.Profile.email.rawValue.fieldKey, .string, .required)
            .field(NameManager.Profile.phone.rawValue.fieldKey, .string, .required)
            .field(NameManager.Profile.city.rawValue.fieldKey, .string, .required)
            .field(NameManager.Profile.description.rawValue.fieldKey, .string, .required)
            .field(NameManager.Profile.title.rawValue.fieldKey, .string, .required)
            .field(NameManager.Profile.github.rawValue.fieldKey, .string, .required)
            .field(NameManager.Profile.linkedin.rawValue.fieldKey, .string, .required)
            .field(NameManager.Profile.condingames.rawValue.fieldKey, .string, .required)
            .create()
    }
    
    // Delete DB
    func revert(on database: Database) async throws {
        try await database.schema(NameManager.Profile.schema.rawValue).delete()
    }
}
