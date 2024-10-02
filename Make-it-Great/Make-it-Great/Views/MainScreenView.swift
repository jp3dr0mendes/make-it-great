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
    
    @State private var selectedCategory: StorageType = .refrigerator
    @State var isPresented: Bool = false
    
//    let container = ModelContainer(for: Food.self)
    
    var body: some View {
        
        VStack {
            
            SegmentedControlComponent(selectedCategory: $selectedCategory)
            
            ForEach(foods){
                food in
                Text(verbatim: "\(food.nome)")
            }
            
            Button("Adicionar Item"){
                isPresented = true            }
        }
        .sheet(isPresented: $isPresented, content: {
            AddItem(isPresented: $isPresented, storage: $selectedCategory)
        })
    }
}

#Preview {
    MainScreenView()
        .modelContainer(for: [Food.self])
}

