//
//  Training.swift
//  
//
//  Created by Kevin Bertrand on 07/10/2022.
//

import Fluent
import Vapor

final class Training: Model, Content {
    // Name of the table
    static let schema: String = "trainings"
    
    // Unique identifier
    @ID()
    var id: UUID?
    
    // Fields
    @Field(key: "title")
    var title: String
    
    @Field(key: "organization")
    var organization: String
    
    @Field(key: "date")
    var date: Date
    
    @Field(key: "document_path")
    var documentPath: String
    
    @Field(key: "icon")
    var icon: String
    
    // Initialization functions
    init() {}
    
    init(id: UUID? = nil,
         title: String,
         organization: String,
         date: Date,
         documentPath: String,
         icon: String) {
        self.id = id
        self.title = title
        self.organization = organization
        self.date = date
        self.documentPath = documentPath
        self.icon = icon
    }
}
