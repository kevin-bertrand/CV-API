//
//  String.swift
//  
//
//  Created by Kevin Bertrand on 28/11/2022.
//

import Fluent
import Foundation

extension String {
    var fieldKey: FieldKey {
        .string(self)
    }
}
