//
//  Project.swift
//  
//
//  Created by Kevin Bertrand on 07/10/2022.
//

import Fluent
import Vapor

final class Project: Model, Content {
    // Name of the table
    static let schema: String = NameManager.Project.schema.rawValue
    
    // Unique identifier
    @ID()
    var id: UUID?
    
    // Fields
    @Field(key: NameManager.Project.title.rawValue.fieldKey)
    var title: String
    
    @Field(key: NameManager.Project.mediaPath.rawValue.fieldKey)
    var mediaPath: String
    
    @Field(key: NameManager.Project.description.rawValue.fieldKey)
    var description: String
    
    @Field(key: NameManager.Project.company.rawValue.fieldKey)
    var company: String
    
    @Field(key: NameManager.Project.date.rawValue.fieldKey)
    var date: Date
    
    @OptionalField(key: NameManager.Project.github.rawValue.fieldKey)
    var github: String?
    
    @Enum(key: NameManager.Project.category.rawValue.fieldKey)
    var category: ProjectCategories
    
    // Initialization functions
    init() {}
    
    init(id: UUID? = nil,
         title: String,
         mediaPath: String,
         description: String,
         company: String,
         date: Date,
         github: String? = nil,
         category: ProjectCategories) {
        self.id = id
        self.title = title
        self.mediaPath = mediaPath
        self.description = description
        self.company = company
        self.date = date
        self.github = github
        self.category = category
    }
}
