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
    var storage: String
    var weight: Int?
    var quantity: Int?
    var type: String
    var consumirAte: Date?
    
    private let FoodTypes:[String] = ["Fruta","Verdura","Carne","Carne","Biscoito","Snack"]
    private let StorageType: [String] = ["Cabinet","Fridge"]
    
    init(storage: StorageType, quantity: Int, type: FoodType, consumirAte: Date?) {
        self.storage = ""
        self.quantity = quantity
        self.type = ""
        
        if let data = consumirAte {
            self.consumirAte = consumirAte
        } else { }
        
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
