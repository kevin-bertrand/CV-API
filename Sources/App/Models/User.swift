//
//  User.swift
//  
//
//  Created by Kevin Bertrand on 10/10/2022.
//

import Fluent
import Vapor

final class User: Model, Content {
    // Name of the table
    static let schema: String = NameManager.User.schema.rawValue
    
    // Unique identifier
    @ID(key: .id)
    var id: UUID?
    
    // Fields
    @Field(key: NameManager.User.email.rawValue.fieldKey)
    var email: String
    
    @Field(key: NameManager.User.passwordHash.rawValue.fieldKey)
    var passwordHash: String
    
    // Initialization functions
    init() {}
    
    init(id: UUID? = nil, email: String, passwordHash: String) {
        self.id = id
        self.email = email
        self.passwordHash = passwordHash
    }
}
