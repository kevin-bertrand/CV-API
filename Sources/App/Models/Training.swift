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
    static let schema: String = NameManager.Training.schema.rawValue
    
    // Unique identifier
    @ID()
    var id: UUID?
    
    // Fields
    @Field(key: NameManager.Training.title.rawValue.fieldKey)
    var title: String
    
    @Field(key: NameManager.Training.organization.rawValue.fieldKey)
    var organization: String
    
    @Field(key: NameManager.Training.date.rawValue.fieldKey)
    var date: Date
    
    @Field(key: NameManager.Training.documentPath.rawValue.fieldKey)
    var documentPath: String
    
    @Field(key: NameManager.Training.icon.rawValue.fieldKey)
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
