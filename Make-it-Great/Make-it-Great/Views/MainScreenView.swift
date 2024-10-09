//
//  MainScreenView.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 02/10/24.
//

import SwiftUI
import SwiftData

struct MainScreenView: View {
    
    @Environment(\.modelContext) var context
    
    @Query(sort: \Food.consumirAte) var foods: [Food]
    
    @Query(
        filter: #Predicate<Food> { food in
            food.storage ==  "Geladeira"
        }
    )
    var foodGeladeira: [Food]
    
    @Query(
        filter: #Predicate<Food> { food in
            food.storage ==  "Armário"
        }
    )
    var foodArmario: [Food]
    
    @State private var selectedCategory: StorageType = .refrigerator
    @State var isPresentedSheet: Bool = false
    @State var isPresentedMenu: Bool = false
//    @State var isAnimating: Bool = false
    

    
    
    var body: some View {
        NavigationStack{
            
            VStack {
                
                Menu("", systemImage: "plus.circle.fill") {
                    
                    Button("Adicionar Manualmente"){
                        isPresentedSheet = true
                    }
                    //                    NavigationView {
//                    Button("Scannear"){
                    NavigationLink(destination: ScreenScan(isPresentedMenu: $isPresentedMenu)) {
                        Text("Scannear")
                    }
                    //
                }
                
                SegmentedControlComponent(selectedCategory: $selectedCategory)
                
                VStack{
                    switch selectedCategory {
                    case .refrigerator:
                        ForEach(foodGeladeira){
                            food in
                            ListFood(comida: food)
                        }
                    case .cabinet:
                        ForEach(foodArmario){
                            food in
                            ListFood(comida: food)
                        }
                    }
                }
                
//                Button("Adicionar Item"){
//                    isPresentedSheet = true
//                }
                
                ButtonView(isPresentedSheet: $isPresentedSheet)
                  
                    
                
            }
            .sheet(isPresented: $isPresentedSheet, content: {
                AddItem(isPresented: $isPresentedSheet, storage: $selectedCategory)
            })
            
        }
    }
}


#Preview {
    MainScreenView()
        .modelContainer(for: [Food.self])
}

