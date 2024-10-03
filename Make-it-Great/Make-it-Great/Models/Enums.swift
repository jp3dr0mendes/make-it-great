//
//  Enums.swift
//  Make-it-Great
//
//  Created by João Pedro Albuquerque on 01/10/24.
//

import Foundation

enum StorageType: String, CaseIterable, Identifiable {
    
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
