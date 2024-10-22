//
//  IdentifiedFoodScreen.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 04/10/24.
//

import SwiftData
import SwiftUI

struct IdentifiedFoodScreen: View {
    
    @Binding var detectedFoods: [Food]
    @Binding var storage: StorageType
    @Binding var isPresented: Bool
    @State var selectedItems: Set<Food> = []
    
    @Environment(\.modelContext) var context
    
    @Query var foods: [Food]

    func addFood(comidas: [Food]){
        comidas.forEach{ comida in
            context.insert(comida)
            try! context.save()
        }
        
        try! context.save()
    }
    var body: some View {
        
        NavigationView{
            VStack {
                Text("Identified Food")
                
                ListFood(comidas: $detectedFoods, selectedCategory: $storage, selectedItems: $selectedItems, selected: $isPresented)

                NavigationLink(destination: MainScreenView()) {
                    Button("Add Foods"){
                        addFood(comidas: detectedFoods)
                    }
                    
                    .font(.title2)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
        }
    }
}

//#Preview {
//    IdentifiedFoodScreen()
//}
