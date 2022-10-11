//
//  MissionsCodable.swift
//  
//
//  Created by Kevin Bertrand on 11/10/2022.
//

import Foundation

extension Mission {
    struct Create: Codable {
        let title: String
        let tasks: String
    }
    
    struct Getting: Codable {
        let title: String
        let tasks: String
    }
}
