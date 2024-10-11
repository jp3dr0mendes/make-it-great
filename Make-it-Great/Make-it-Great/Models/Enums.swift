//
//  Enums.swift
//  Make-it-Great
//
//  Created by João Pedro Albuquerque on 01/10/24.
//

import Foundation
import SwiftUI

enum StorageType: String, CaseIterable, Identifiable {
    
    case refrigerator
    case cabinet
    
    var id: String { self.rawValue }
    
    var color: Color {
        switch self {
        case .refrigerator:
            return Color("BrownFruits")
        case .cabinet:
            return Color("GreenVegetables")
        }
    }
    
    var image: String {
        switch self {
        case .refrigerator:
            return "Fruits"
        case .cabinet:
            return "Vegetables"
        }
    }

    var description: String {
        switch self {
        case .refrigerator:
            return "Frutas"
        case .cabinet:
            return "Hortaliças"
       
        }
    }
}

enum FoodType: CaseIterable {
    case Fruta
    case Vegetal
    case Carne
    case Tempero
    case Laticinio
    case Massa
    case Bebida
    //add mais categorias
}

enum CountType: CaseIterable {
    case Peso
    case Unidade
}
