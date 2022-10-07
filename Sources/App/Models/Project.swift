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
    static let schema: String = "project"
    
    // Unique identifier
    @ID()
    var id: UUID?
    
    // Fields
    @Field(key: "title")
    var title: String
    
    @Field(key: "media_path")
    var mediaPath: String
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "company")
    var company: String
    
    @Field(key: "date")
    var date: Date
    
    // Initialization functions
    init() {}
    
    init(id: UUID? = nil,
         title: String,
         mediaPath: String,
         description: String,
         company: String,
         date: Date) {
        self.id = id
        self.title = title
        self.mediaPath = mediaPath
        self.description = description
        self.company = company
        self.date = date
    }
}
