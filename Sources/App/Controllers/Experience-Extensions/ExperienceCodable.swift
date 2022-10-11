//
//  ExperienceCodable.swift
//  
//
//  Created by Kevin Bertrand on 11/10/2022.
//

import Foundation

extension Experience {
    struct Create: Codable {
        let title: String
        let company: String
        let location: String
        let startDate: Date
        let endDate: Date?
        let icon: String
        let missions: [Mission.Create]
    }
    
    struct Getting: Codable {
        let title: String
        let company: String
        let location: String
        let startDate: Date
        let endDate: Date?
        let icon: String
        let missions: [Mission.Getting]
    }
}
