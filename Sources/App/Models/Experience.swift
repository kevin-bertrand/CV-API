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
    static let schema: String = "experience"
    
    // Unique identifier
    @ID()
    var id: UUID?
    
    // Fields
    @Field(key: "title")
    var title: String
    
    @Field(key: "company")
    var company: String
    
    @Field(key: "location")
    var location: String
    
    @Field(key: "start-date")
    var startDate: Date
    
    @OptionalField(key: "end-date")
    var endDate: Date?
    
    @Children(for: \.$experience)
    var missions: [Mission]
    
    // Initialization functions
    init() {}
    
    init(id: UUID? = nil, title: String, company: String, location: String, startDate: Date, endDate: Date? = nil) {
        self.id = id
        self.title = title
        self.company = company
        self.location = location
        self.startDate = startDate
        self.endDate = endDate
    }
}
