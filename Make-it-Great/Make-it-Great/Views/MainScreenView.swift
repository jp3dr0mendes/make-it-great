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
    @State var comidas: [Food] = []
    @State var selectedItems: Set<Food> = []
    @State private var filteredFoods: [Food] = []



    var body: some View {
        
        NavigationStack{
            
            VStack {
                
                Text("My Items")
                    .foregroundColor(.blue)
                    .padding(.trailing)
                
                SegmentedControlComponent(selectedCategory: $selectedCategory)
                    .onChange(of: selectedCategory) { newValue in
                        // Atualiza a lista filtrada de acordo com a categoria selecionada:
                        updateFilteredFoods()
                    }
                
               
                //Menu para adicionar via Scan e Manualmente:
                HStack {
                    
                    //Ztack para desenhar botoes na mesma linha
                    ZStack {
                        
                        SelectButton(showingButton: $showingButton)
                            .opacity(showingButton ? 0 : 1)
                        
                        if showingButton {
                            
                            CancelAndSelectAllButton(showingButton: $showingButton)
                    
                        }else {
                            
                            AddMenu(isPresentedMenu: $isPresentedMenu, isPresentedSheet: $isPresentedSheet)
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
                        ListFood(comidas: $filteredFoods, selectedItems: $selectedItems)
                    }
                }
                
//                Button("Adicionar Item"){
//                    isPresentedSheet = true
//                }
                
                ButtonView(deleteAction: {
                    // Chama a função de deletar diretamente da ListFood
                    deleteSelectedItems()
                })
                
                
            
            }
            .sheet(isPresented: $isPresentedSheet, content: {
                AddItem(isPresented: $isPresentedSheet, storage: $selectedCategory)
            })
            .onAppear {
                // Inicializa a lista filtrada ao aparecer
                updateFilteredFoods()
            }
        }
    }
    
    private func updateFilteredFoods() {
            // Atualiza a lista filtrada com base na categoria selecionada
            switch selectedCategory {
            case .refrigerator:
                filteredFoods = foodGeladeira
            case .cabinet:
                filteredFoods = foodArmario
            }
        }
    
    private func deleteSelectedItems() {
            // Remove os itens selecionados do contexto
            for comida in selectedItems {
                context.delete(comida)
            }
            selectedItems.removeAll() // Limpa os itens selecionados
            updateFilteredFoods() // Atualiza a lista filtrada após a deleção
        }

}



#Preview {
    MainScreenView()
        .modelContainer(for: [Food.self])
}

