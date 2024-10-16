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
   @State private var showingButton: Bool = false


    var body: some View {
        
        NavigationStack{
            
            VStack {
                
                Text("My Items")
                    .foregroundColor(.blue)
                    .padding(.trailing)
                
                SegmentedControlComponent(selectedCategory: $selectedCategory)
                
               
                //Menu para adicionar via Scan e Manualmente:
                HStack {
                    
                    //Ztack para desenhar botoes na mesma linha
                    ZStack {
                        
                        SelectButton(showingButton: $showingButton)
                            .opacity(showingButton ? 0 : 1)
                           
                            

                        if showingButton {
                            
                            CancelAndSelectAllButton(showingButton: $showingButton)
                    
                        }
                    }
                    
                    //Spacer()
                    Menu {
                        NavigationLink(destination: ScreenScan(isPresentedMenu: $isPresentedMenu)) {
                            Text("Scannear")
                            Image(systemName: "camera.viewfinder")
                        }
                        
                        Button("Adicionar Manualmente", systemImage: "pencil") {
                            isPresentedSheet = true
                        }
                    } label: {
                        Label("", systemImage: "plus.circle.fill")
                            .font(.system(size: 25)) // Ajuste o tamanho do ícone aqui
                    }.padding()
                }
                
                //Lista personalizada de comidas a ScroolView torna a ListFood uma lista scrolável
                ScrollView {
                    VStack {
                        
                        switch selectedCategory {
                        case .refrigerator:
                            ForEach(foodGeladeira){
                                food in
                                //ListFood(comida: food)
                                ListFood(comidas: foodGeladeira)

                            }
                        case .cabinet:
                            ForEach(foodArmario){
                                food in
                                //ListFood(comida: food)
                                ListFood(comidas: foodArmario)
                            }
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

