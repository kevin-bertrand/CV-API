//
//  Mission.swift
//  
//
//  Created by Kevin Bertrand on 07/10/2022.
//

import Fluent
import Vapor

final class Mission: Model, Content {
    // Name of the table
    static let schema: String = "mission"
    
    // Unique identifier
    @ID()
    var id: UUID?
    
    // Fields
    @Field(key: "title")
    var title: String
    
    @Field(key: "tasks")
    var tasks: String
    
    @Parent(key: "experience_id")
    var experience: Experience
    
    // Initialization functions
    init() {}
    
    init(id: UUID? = nil, title: String, tasks: String, experienceID: Experience.IDValue) {
        self.id = id
        self.title = title
        self.tasks = tasks
        self.$experience.id = experienceID
    }
}
