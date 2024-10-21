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
//    var comida: Food
    //Lista de alimentos:
//    @State var comidas: [Food]
    //Armazena alimetos selecionados:
//    @State var selectedItems: Set<Food> = []
    // Lista de alimentos (agora um binding)
    @Binding var comidas: [Food]
    // Armazena alimentos selecionados (agora um binding)
    @Binding var selectedCategory: StorageType
    @Binding var selectedItems: Set<Food>
    @Binding var selected: Bool
    
    @State var isPresentedSheet: Bool = false
    
    var body: some View {
        
        
        VStack {
            
           
            ForEach(comidas) { comida in
//                Divider()
                HStack {
                    
                    //Checkbox personalizado:
                    Button (action: {
                        toggleSelection(of: comida)
                    }) {
                        if selected == true {
                            Image(systemName: selectedItems.contains(comida) ? "checkmark.circle.fill" : "poweroff" )
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(selectedItems.contains(comida) ? .green : .gray)
                        }
                    }/*.padding(.leading, 10)*/ //Afasta o checkbox da imagem, acho que esse padding é desnecessario
                    
                    //Spacer()
                    
                    Button( action: { isPresentedSheet = true }) {
                        
                        Image("imageTest") //Preciso fazer um model para colocar a imagem certa aqui
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                        //.foregroundColor(.yellow)
                            .overlay(Circle().stroke(selectedCategory == .refrigerator ? Color(.brownFruits) : Color(.greenVegetables), lineWidth: 1))
                            .shadow(radius: 10)
                        
                        //Nome da Comida e Quantidade:
                        VStack (alignment: .leading) {
                            Text(comida.nome)
                                .font(.callout)
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                                .truncationMode(.tail)
                            
                            Text("1x")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            //Preciso colocar a lógica de deletar
                            //                        Button("Apagar"){
                            //                            context.delete(comida)
                            //                        }
                            
                        }//.padding(.leading, 10)
                        
                        
                        Spacer(minLength: 10) //Esse Spacer afasta o nome da comida e os dias alguns pixels, não sei se é tão necessário.
                        
                        Text("30 dias para o consumo")
                            .font(.caption)
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(.gray)
                        // .padding(.trailing, 10) //Esse pading afasta o 30 dias... da extremidade direita
                        //Spacer()
                    }
                    
                    .sheet(isPresented: $isPresentedSheet){
                        
//                        let food: Food = comida
                        EditItemSheet(isPresented: $isPresentedSheet, item: comida, peso: comida.weight ?? 0.0, unidades: comida.units ?? 0)
                    }
                }
                //.padding(.leading, 10)
                
                Divider() //Linha horizontal que divide os elementos
            }
            
        }
    }
    
    private func toggleSelection(of comida: Food) {
        if selectedItems.contains(comida) {
            selectedItems.remove(comida)
        } else {
            selectedItems.insert(comida)
        }
    }
    
    //Funcao que é chamada quando aperta o botao para deletar os itens:
//    func deleteSelectedItems() {
//        for comida in selectedItems {
//            if let index = comidas.firstIndex(of: comida) {
//                
//                comidas.remove(at: index)
//                context.delete(comida)
//            }
//        }
//        selectedItems.removeAll()
//    }
}

//#Preview {
//    ListFood(comida: Food(nome: "Item food visualization Named sdfads dsf asd fads dafs adf", storage: .refrigerator, type: .Bebida, consumirAte: Date(timeInterval: 7*60*60*24, since: Date.now), units: 2, weight: nil))
//        .modelContainer(for: [Food.self])
//}
//#Preview {
//    ListFood(comida: Food, comidas: [
//        Food(nome: "Banana", storage: .refrigerator, type: .Fruta, consumirAte: Date(), units: 3, weight: nil),
//        Food(nome: "Maçã", storage: .refrigerator, type: .Fruta, consumirAte: Date(), units: 1, weight: nil)
//    ])
//    .modelContainer(for: [Food.self])
//}
//
#Preview {
    MainScreenView()
}
