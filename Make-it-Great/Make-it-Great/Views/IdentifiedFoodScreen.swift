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
    @Binding var navegarAnterior: Bool
    @State var navegar: Bool = false
    
    @State var selectedItems: Set<Food> = []
    
    @Environment(\.modelContext) var context
    
    @Query var foods: [Food]
    
    func addFood(comidas: [Food]){
        comidas.forEach{ comida in
            context.insert(comida)
            try! context.save()
        }
        
        //        try! context.save()
    }
    var body: some View {
        
        NavigationView{
            
            VStack(spacing: 20) {
                HStack {
                    Text("Comidas identificadas")
                        .foregroundStyle(.purpleItens)
                        .font(.system(.title))
                        .fontDesign(.rounded)
                    Spacer()
                }
                ScrollView {
                    ListFood(comidas: $detectedFoods, selectedCategory: $storage, selectedItems: $selectedItems, selected: $isPresented, scanList: .constant(true))
                }
                Spacer()
                
                Button{
                    addFood(comidas: detectedFoods)
                    navegarAnterior = false
                    //                    print(navegar)
                } label: {
                    Text("Adicionar comidas")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(storage == .refrigerator ? .brownFruits : .greenVegetables)
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            
        }
        
    }
}

//#Preview {
//    IdentifiedFoodScreen()
//}
