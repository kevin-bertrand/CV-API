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
    static let schema: String = "profile"
    
    // Unique identifier
    @ID()
    var id: UUID?
    
    // Fields
    @Field(key: "firstname")
    var firstname: String
    
    @Field(key: "lastname")
    var lastname: String
    
    @Field(key: "email")
    var email: String
    
    @Field(key: "phone")
    var phone: String
    
    @Field(key: "city")
    var city: String
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "github")
    var github: String
    
    @Field(key: "linkedin")
    var linkedin: String
    
    @Field(key: "codingames")
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
