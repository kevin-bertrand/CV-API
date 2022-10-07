//
//  Skill.swift
//  
//
//  Created by Kevin Bertrand on 07/10/2022.
//

import Fluent
import Vapor

final class Skill: Model, Content {
    // Name of the table
    static let schema: String = "skill"
    
    // Unique identifier
    @ID()
    var id: UUID?
    
    // Fields
    @Field(key: "title")
    var title: String
    
    @Field(key: "image")
    var image: String
    
    @Enum(key: "category")
    var category: SkillsCategories
    
    // Initialization functions
    init() {}
    
    init(id: UUID? = nil, title: String, image: String, category: SkillsCategories) {
        self.id = id
        self.title = title
        self.image = image
        self.category = category
    }
}
