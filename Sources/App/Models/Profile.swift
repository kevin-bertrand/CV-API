//
//  Profile.swift
//  
//
//  Created by Kevin Bertrand on 07/10/2022.
//

import Fluent
import Vapor

final class Profile: Model, Content {
    // Name of the table
    static let schema: String = NameManager.Profile.schema.rawValue
    
    // Unique identifier
    @ID()
    var id: UUID?
    
    // Fields
    @Field(key: NameManager.Profile.firstname.rawValue.fieldKey)
    var firstname: String
    
    @Field(key: NameManager.Profile.lastname.rawValue.fieldKey)
    var lastname: String
    
    @Field(key: NameManager.Profile.email.rawValue.fieldKey)
    var email: String
    
    @Field(key: NameManager.Profile.phone.rawValue.fieldKey)
    var phone: String
    
    @Field(key: NameManager.Profile.city.rawValue.fieldKey)
    var city: String
    
    @Field(key: NameManager.Profile.description.rawValue.fieldKey)
    var description: String
    
    @Field(key: NameManager.Profile.title.rawValue.fieldKey)
    var title: String
    
    @Field(key: NameManager.Profile.github.rawValue.fieldKey)
    var github: String
    
    @Field(key: NameManager.Profile.linkedin.rawValue.fieldKey)
    var linkedin: String
    
    @Field(key: NameManager.Profile.condingames.rawValue.fieldKey)
    var codingames: String
    
    // Initialization functions
    init() {}
    
    init(id: UUID? = nil,
         firstname: String,
         lastname: String,
         email: String,
         phone: String,
         city: String,
         description: String,
         title: String,
         github: String,
         linkedin: String,
         codingames: String) {
        self.id = id
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.phone = phone
        self.city = city
        self.description = description
        self.title = title
        self.github = github
        self.linkedin = linkedin
        self.codingames = codingames
    }
}
