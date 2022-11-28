//
//  Experience.swift
//  
//
//  Created by Kevin Bertrand on 07/10/2022.
//

import Fluent
import Vapor

final class Experience: Model, Content {
    // Name of the table
    static let schema: String = NameManager.Experience.schema.rawValue
    
    // Unique identifier
    @ID()
    var id: UUID?
    
    // Fields
    @Field(key: NameManager.Experience.title.rawValue.fieldKey)
    var title: String
    
    @Field(key: NameManager.Experience.company.rawValue.fieldKey)
    var company: String
    
    @Field(key: NameManager.Experience.location.rawValue.fieldKey)
    var location: String
    
    @Field(key: NameManager.Experience.startDate.rawValue.fieldKey)
    var startDate: Date
    
    @Field(key: NameManager.Experience.icon.rawValue.fieldKey)
    var icon: String
    
    @OptionalField(key: NameManager.Experience.endDate.rawValue.fieldKey)
    var endDate: Date?
    
    @Children(for: \.$experience)
    var missions: [Mission]
    
    // Initialization functions
    init() {}
    
    init(id: UUID? = nil,
         title: String,
         company: String,
         location: String,
         startDate: Date,
         endDate: Date? = nil,
         icon: String) {
        self.id = id
        self.title = title
        self.company = company
        self.location = location
        self.startDate = startDate
        self.endDate = endDate
        self.icon = icon
    }
}
