//
//  SegmentedControlModel.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 01/10/24.
//

import Foundation

// TaskCategory.swift
import Foundation

enum TaskCategory: String, CaseIterable, Identifiable {
    
    case refrigerator
    case cabinet


    var id: String { self.rawValue }

    var description: String {
        switch self {
        case .refrigerator:
            return "Refrigerator"
        case .cabinet:
            return "Cabinet"
       
        }
    }
}

