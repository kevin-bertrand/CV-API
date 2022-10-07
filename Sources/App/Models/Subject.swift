//
//  Subject.swift
//  
//
//  Created by Kevin Bertrand on 07/10/2022.
//

import Fluent
import Vapor

final class Subject: Model, Content {
    // Name of the table
    static let schema: String = "subject"
    
    // Unique identifier
    @ID()
    var id: UUID?
    
    // Fields
    @Field(key: "title")
    var title: String
    
    @Parent(key: "education_id")
    var education: Education
    
    // Initialization functions
    init() {}
    
    init(id: UUID? = nil, title: String, educationID: Education.IDValue) {
        self.id = id
        self.title = title
        self.$education.id = educationID
    }
}
