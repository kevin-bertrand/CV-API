//
//  ProjectCodable.swift
//  
//
//  Created by Kevin Bertrand on 11/10/2022.
//

import Foundation

extension Project {
    struct Getting: Codable {
        let title: String
        let mediaPath: String
        let description: String
        let company: String
        let date: Int
        let github: String?
    }
}
