//
//  Education.swift
//  
//
//  Created by Kevin Bertrand on 07/10/2022.
//

import Fluent
import Vapor

final class Education: Model, Content {
    // Name of the table
    static let schema: String = "education"
    
    // Unique identifier
    @ID()
    var id: UUID?
    
    // Fields
    @Field(key: "school")
    var school: String
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "level")
    var level: String
    
    @Field(key: "location")
    var location: String
    
    @Field(key: "icon")
    var icon: String
    
    @OptionalField(key: "document_path")
    var documentPath: String?
    
    @Children(for: \.$education)
    var subjects: [Subject]
    
    // Initialization functions
    init() {}
    
    init(id: UUID? = nil,
         school: String,
         title: String,
         level: String,
         location: String,
         icon: String,
         documentPath: String?) {
        self.id = id
        self.school = school
        self.title = title
        self.level = level
        self.location = location
        self.icon = icon
        self.documentPath = documentPath
    }
}
