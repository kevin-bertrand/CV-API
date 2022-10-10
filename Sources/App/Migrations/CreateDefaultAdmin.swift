//
//  CreateDefaultAdmin.swift
//  
//
//  Created by Kevin Bertrand on 10/10/2022.
//

import Fluent
import Vapor

struct CreateDefaultAdmin: AsyncMigration {
    // Create DB
    func prepare(on database: Database) async throws {
        let email = Environment.get("ADMINISTRATOR_EMAIL")
        let password = Environment.get("ADMINISTRATOR_PASSWORD")
        let administrator = User(email: email ?? "", passwordHash: try Bcrypt.hash(password ?? ""))
        try await administrator.save(on: database)
    }
    
    // Delete DB
    func revert(on database: Database) async throws {}
}
