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
    static let schema: String = NameManager.Education.schema.rawValue
    
    // Unique identifier
    @ID()
    var id: UUID?
    
    // Fields
    @Field(key: NameManager.Education.school.rawValue.fieldKey)
    var school: String
    
    @Field(key: NameManager.Education.title.rawValue.fieldKey)
    var title: String
    
    @Field(key: NameManager.Education.level.rawValue.fieldKey)
    var level: String
    
    @Field(key: NameManager.Education.location.rawValue.fieldKey)
    var location: String
    
    @Field(key: NameManager.Education.icon.rawValue.fieldKey)
    var icon: String
    
    @Field(key: NameManager.Education.endingDate.rawValue.fieldKey)
    var endingDate: Date
    
    @OptionalField(key: NameManager.Education.documentPath.rawValue.fieldKey)
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
         endingDate: Date,
         documentPath: String?) {
        self.id = id
        self.school = school
        self.title = title
        self.level = level
        self.location = location
        self.icon = icon
        self.endingDate = endingDate
        self.documentPath = documentPath
    }
}
