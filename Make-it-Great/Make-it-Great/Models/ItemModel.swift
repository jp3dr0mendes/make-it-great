//
//  ItemModel.swift
//  Make-it-Great
//
//  Created by João Pedro Albuquerque on 19/11/24.
//

import Foundation
import SwiftData

@Model
class ItemModel: Hashable {
    
    var nome: String
    var emoji: String?
    var consumirAte: Date?
    var quantity: String
    
    init(nome: String, emoji: String?, consumirAte: Date?, quantity: String) {
        self.nome = nome
        self.emoji = emoji
        self.quantity = quantity
        
        if let data = consumirAte {
            self.consumirAte = data
        } else {
            self.consumirAte = Date()
        }
    }
}
