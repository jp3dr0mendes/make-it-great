//
//  MainScreenView.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 02/10/24.
//

import SwiftUI
import SwiftData

struct MainScreenView: View {
    
    @Query(sort: \Food.consumirAte) var foods: [Food]
    @Environment(\.modelContext) var context
//    @Query(filter: #Predicate { $0.storage == "Geladeira" }) var food: [Food]
    @State private var selectedCategory: StorageType = .refrigerator
    @State var isPresentedSheet: Bool = false
    @State var isPresentedMenu: Bool = false
//    let container = ModelContainer(for: Food.self)
    
    var foodFridge: [Food] = []
    var foodCabinet: [Food] = []
    
    
    var body: some View {
        
        VStack {
            
            SegmentedControlComponent(selectedCategory: $selectedCategory)
            
            ForEach(foods){
                food in
                ListFood(comida: food)
            }
            
            Menu("Adicionar Item"){
                Button("Adicionar Manualmente"){
                    isPresentedSheet = true
                }
                
                Button("Scannear") {
                    //Logica para passar para a tela da camera
                    isPresentedMenu = false
                }
            }
            
        }
        .sheet(isPresented: $isPresentedSheet, content: {
            AddItem(isPresented: $isPresentedSheet, storage: $selectedCategory)
        })
    }
}

#Preview {
    MainScreenView()
        .modelContainer(for: [Food.self])
}

