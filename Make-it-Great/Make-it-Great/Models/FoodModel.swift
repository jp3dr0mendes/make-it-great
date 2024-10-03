//
//  FoodModel.swift
//  Make-it-Great
//
//  Created by João Pedro Albuquerque on 01/10/24.
//

import SwiftData
import Foundation

@Model
class Food{
    var nome: String
    var storage: String
    var units: Int?
    var weight: Float?
    var type: String
    var consumirAte: Date
    
    init(nome: String, storage: StorageType, type: FoodType, consumirAte: Date, units: Int?, weight: Float?) {
        self.nome = nome
        self.storage = ""
        self.type = ""
        self.consumirAte = consumirAte
        
        if let peso = weight{
            self.weight = peso
        } else if let unidades = units{
            self.units = unidades
        }
        
        self.storage = checkStorage(storage: storage)
        self.type = checkFoodType(foodType: type)
    }
    
    private func checkStorage(storage: StorageType) -> String{
        
        var storageType: String{
            
        switch storage {
        case .cabinet:
            return "Armário"
        case .refrigerator:
            return "Geladeira"
        }
    }
        return storageType
    }
    
    private func checkFoodType(foodType: FoodType) -> String {
        var food: String {
            switch foodType{
            case .Fruta:
                return "Fruta"
            case .Vegetal:
                return "Vegetal"
            case .Carne:
                return "Carne"
            case .Tempero:
                return "Tempero"
            case .Laticinio:
                return "Laticínio"
            case .Massa:
                return "Massa"
            case .Bebida:
                return "Bebidas"
            }
        }
        
        return food
    }
}
