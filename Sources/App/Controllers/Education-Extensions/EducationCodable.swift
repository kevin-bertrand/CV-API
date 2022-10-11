//
//  EducationCodable.swift
//  
//
//  Created by Kevin Bertrand on 10/10/2022.
//

import Foundation

extension Education {
    struct Create: Codable {
        let school: String
        let title: String
        let level: String
        let location: String
        let icon: String
        let endingDate: Date
        let documentPath: String?
        let subjects: [String]
    }
    
    struct Getting: Codable {
        let school: String
        let title: String
        let level: String
        let location: String
        let icon: String
        let endingDate: Date
        let documentPath: String?
        let subjects: [String]
    }
}
