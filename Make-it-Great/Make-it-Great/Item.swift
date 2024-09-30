//
//  Item.swift
//  Make-it-Great
//
//  Created by João Pedro Albuquerque on 30/09/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
