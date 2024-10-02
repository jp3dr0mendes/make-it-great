//
//  ListFood.swift
//  Make-it-Great
//
//  Created by João Pedro Albuquerque on 02/10/24.
//

import Foundation
import SwiftUI
import SwiftData

struct ListFood: View {
    @Environment(\.modelContext) var context
    var comida: Food
    var body: some View {
        HStack{
            Text(comida.nome)
        }
    }
}

#Preview {
    ListFood(comida: Food(nome: "seila", storage: .refrigerator, type: .Bebida, consumirAte: Date(timeInterval: 7*60*60*24, since: Date.now), units: 2, weight: nil))
        .modelContainer(for: [Food.self])
}
