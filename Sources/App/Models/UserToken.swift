//
//  UserToken.swift
//  
//
//  Created by Kevin Bertrand on 10/10/2022.
//

import Fluent
import Vapor

final class UserToken: Model, Content {
    // Name of the table
    static let schema: String = NameManager.UserToken.schema.rawValue
    
    // Unique identifier
    @ID(key: .id)
    var id: UUID?
    
    // Fields
    @Field(key: NameManager.UserToken.value.rawValue.fieldKey)
    var value: String
    
    @Parent(key: NameManager.UserToken.userId.rawValue.fieldKey)
    var user: User
    
    // Initialization functions
    init() {}
    
    init(id: UUID? = nil, value: String, userID: User.IDValue) {
        self.id = id
        self.value = value
        self.$user.id = userID
    }
}

