//
//  FoodModel.swift
//  Make-it-Great
//
//  Created by João Pedro Albuquerque on 01/10/24.
//

import SwiftData
import Foundation

@Model
class Food {

    var nome: String
    var emoji: String?
    var storage: String
    var units: Int?
    var weight: Float?
    var type: String
    var consumirAte: Date?
//    var countType: String
    
    init(nome: String, emoji: String?, storage: StorageType, type: FoodType, consumirAte: Date?, units: Int?, weight: Float?) {
        self.nome = nome
        self.emoji = emoji
        self.storage = ""
        self.type = ""
//        self.countType = ""
        
        
        if let peso = weight{
            self.weight = peso
        } else if let unidades = units{
            self.units = unidades
        }
        
        if let data = consumirAte {
            self.consumirAte = data
        } else {
            self.consumirAte = Date(timeInterval: 7*60*60*24, since: Date.now)
        }
        
        self.storage = checkStorage(storage: storage)
        self.type = checkFoodType(foodType: type)
//        self.countType = checkUnityType(unit: countType)
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
    
    private func checkUnityType(unit: CountType) -> String {
        var count: String {
            switch unit {
            case .Peso:
                return "Peso"
            case .Unidade:
                return "Unidade"
            }
        }
        
        return count
    }
}
