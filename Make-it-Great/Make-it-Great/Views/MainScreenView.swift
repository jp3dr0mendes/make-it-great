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
    
    @Query var foods: [Food]
    
    @Query(
        filter: #Predicate<Food> { food in 
            food.type ==  "Fruta"
        }
    )
    var foodGeladeira: [Food]
    
    @Query(
        filter: #Predicate<Food> { food in
            food.type ==  "Vegetal"
        }
    )
    var foodArmario: [Food]
    
    
    //@State private var selectedCategory: StorageType = .refrigerator
    @State private var selectedFood: FoodType = .Fruta
    @State var isPresentedSheet: Bool = false
    @State var isPresentedMenu: Bool = false
//    @State var isAnimating: Bool = false
    @State private var showingButton: Bool = false
    @State var comidas: [Food] = []
    @State var selectedItems: Set<Food> = []
    @State private var filteredFoods: [Food] = []
    @State var selected: Bool = false
    @State var isRemoved: Bool = false


    var body: some View {
        
        NavigationStack{
            
            
            VStack(spacing: 20) {
                
                HStack {
                    Text("Meus Itens")
                        .foregroundStyle(.purpleItens)
                        .font(.system(.title))
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                    Spacer()
                }
                
                SegmentedControlComponent(selectedCategory: $selectedFood)
                    .onChange(of: selectedFood) {
                        // Atualiza a lista filtrada de acordo com a categoria selecionada:
                        updateFilteredFoods()
                    }
                
                if filteredFoods.isEmpty {
                                AddMenu(isPresentedMenu: $isPresentedMenu, isPresentedSheet: $isPresentedSheet, foodType: $selectedFood)
                    VStack {
                        Text("Você não tem itens adicionados ainda.")
                            .lineLimit(3)
                            .font(.title)
                            .fontDesign(.rounded)
                        Text("Vamos lá!")
                            .font(.title)
                            .fontDesign(.rounded)
                    }
                    .foregroundStyle(.purpleItens)
                    Spacer()
                    if selectedFood == .Fruta {
                        Image("EmptyFruits")
                            .resizable()
                            .scaledToFit()
                    } else if selectedFood == .Vegetal {
                        Image("EmptyVegetables")
                            .resizable()
                            .scaledToFit()
                    }
                } else {
                    //Branch...
                    //Menu para adicionar via Scan e Manualmente:
                    HStack {
                        
                        //Ztack para desenhar botoes na mesma linha
                        ZStack {
                            
                            SelectButton(showingButton: $showingButton, selected: $selected)
                                .opacity(showingButton ? 0 : 1)
                            
                            if showingButton {
                                
                                CancelAndSelectAllButton(showingButton: $showingButton, selected: $selected, selectedItems: $selectedItems, comidas: $filteredFoods)
                                
                            } else {
                                AddMenu(isPresentedMenu: $isPresentedMenu, isPresentedSheet: $isPresentedSheet, foodType: $selectedFood)
                            }
                        }
                        
                        //Spacer()
                        
                    }
                    
                    //Lista personalizada de comidas a ScroolView torna a ListFood uma lista scrolável
                    //                ScrollView {
                    //                    VStack {
                    //                        // Usar o estado filtrado na lista
                    //                        ForEach(filteredFoods, id: \.self) { food in
                    //                            ListFood(comidas: $filteredFoods, selectedItems: $selectedItems)
                    //                        }
                    //                    }
                    //                }
                    ScrollView {
                        VStack {
                            // Passando diretamente filteredFoods para ListFood
                            ListFood(comidas: $filteredFoods, selectedCategory: $selectedFood, selectedItems: $selectedItems, selected: $selected, scanList: .constant(false))
                            //.transition(.slide)
                            //.transition(.move(edge: .trailing))
                            //.animation(.easeIn(duration: 2), value: selectedItems)
                            //.transition(.move(edge: .trailing))
                                .animation(.easeIn(duration: 0.4))
                        }
                    }
                    
                    //                Button("Adicionar Item"){
                    //                    isPresentedSheet = true
                    //                }
                    if selected {
                        ButtonView(isRemoved: $isRemoved, selectedItems: $selectedItems, deleteAction: {
                            // Chama a função de deletar diretamente da ListFood
                            deleteSelectedItems()
                            showingButton = false
                            selected = false
                        })
                    }
                }
                    
                //            .onAppear {
                //                // Inicializa a lista filtrada ao aparecer
                //                updateFilteredFoods()
                //            }
                //            .onChange(of: context) {
                //                updateFilteredFoods()
                //            }
            }
            //.navigationBarBackButtonHidden(true)
            .sheet(isPresented: $isPresentedSheet, content: {
                AddItem(isPresented: $isPresentedSheet, food: $selectedFood)
            })
            .onAppear {
                updateFilteredFoods() // Inicializa a lista filtrada ao aparecer
            }
            .onChange(of: foods) {
                updateFilteredFoods() // Atualiza quando a lista de alimentos mudar
            }
            .padding()
        }
    }
    
    private func updateFilteredFoods() {
            // Atualiza a lista filtrada com base na categoria selecionada
        switch selectedFood {
        case .Fruta:
            filteredFoods = foodGeladeira
        case .Vegetal:
            filteredFoods = foodArmario
        }
        }
    
    private func deleteSelectedItems() {
            // Remove os itens selecionados do contexto
        withAnimation {
            for comida in selectedItems {
                context.delete(comida)
            }
        }
        
        
            //Salva o contexto após deletar
        do {
            try context.save()
        } catch {
            print("Erro ao salvar o contexto")
        }
        
        selectedItems.removeAll() // Limpa os itens selecionados
        updateFilteredFoods() // Atualiza a lista filtrada após a deleção
        
        }

}



#Preview {
    MainScreenView()
        .modelContainer(for: [Food.self])
}

