//
//  TrainingCodable.swift
//  
//
//  Created by Kevin Bertrand on 11/10/2022.
//

import Foundation

extension Training {
    struct Getting: Codable {
        let title: String
        let organization: String
        let date: Int
        let documentPath: String
        let icon: String
    }
}
