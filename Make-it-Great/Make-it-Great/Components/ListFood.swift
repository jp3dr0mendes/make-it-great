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
    @Binding var selectedItems: Set<Food>
    @Binding var selected: Bool
    
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
                    ZStack {
                        Text("\(comida.emoji ?? "🍎")")
                            .font(.system(size: 30))
                        // .clipShape(Circle())
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.blue, lineWidth: 1)
                                    .frame(width: 40, height: 40)
                            }
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.blue, lineWidth: 1)
                            .frame(width: 40, height: 40)
                    }
                        
                        //.overlay(Circle().stroke(Color.blue, lineWidth: 1).frame(width: 40, height: 40))
//                    Image("imageTest") //Preciso fazer um model para colocar a imagem certa aqui
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 40, height: 40)
//                        .clipShape(Circle())
//                    //.foregroundColor(.yellow)
//                        .overlay(Circle().stroke(Color.blue, lineWidth: 1))
//                        .shadow(radius: 10)
                    
                    //Nome da Comida e Quantidade:
                    VStack (alignment: .leading) {
                        Text(comida.nome)
                            .font(.callout)
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                            .truncationMode(.tail)
                        Text("1x")
                        //                                .font(.subheadline)
                        //                                .foregroundColor(.gray)
//                        if comida.units != 0 {
//                            Text("\(comida.units ?? 0)x")
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
//                            //Preciso colocar a lógica de deletar
//                            //                        Button("Apagar"){
//                            //                            context.delete(comida)
//                            //                        }
//                            
//                        } else {
//                            Text("\(comida.weight ?? 0.0)kg")
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
//                        }
                    }.padding(.leading, 10)
                    
                    
                    Spacer(minLength: 10) //Esse Spacer afasta o nome da comida e os dias alguns pixels, não sei se é tão necessário.
                    
//                    if comida.consumirAte == 1 {
//                        Text("1 dia para consumo")
//                            .font(.caption)
//                            .multilineTextAlignment(.trailing)
//                            .foregroundColor(.gray)
//                            .padding(.trailing, 10) //Esse pading afasta o 30 dias... da extremidade direita
//                    } else if comida.consumirAte > 1 {
//                        Text("\(comida.consumirAte) dias para consumo")
//                            .font(.caption)
//                            .multilineTextAlignment(.trailing)
//                            .foregroundColor(.gray)
//                            .padding(.trailing, 10) //Esse pading afasta o 30 dias... da extremidade direita
//                    } else if comida.consumirAte == 0 {
//                        Text("Consumir até hoje")
//                            .font(.caption)
//                            .multilineTextAlignment(.trailing)
//                            .foregroundColor(.gray)
//                            .padding(.trailing, 10) //Esse pading afasta o 30 dias... da extremidade direita
//                    } else {
//                        Text("Fora do prazo")
//                            .font(.caption)
//                            .multilineTextAlignment(.trailing)
//                            .foregroundColor(.red)
//                            .padding(.trailing, 10) //Esse pading afasta o 30 dias... da extremidade direita
//                    }
                    
                    Text("30 dias para consumo")
                        .font(.caption)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.gray)
                        .padding(.trailing, 10) //Esse pading afasta o 30 dias... da extremidade direita
                    //Spacer()
                }
                .padding(.leading, 10)
                
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
    
    //private func dateFormatter(dataInicio: Date, dataFim:)
    
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
//#Preview {
//    ListFood(comidas: [Food(nome: "Banana", storage: .refrigerator, type: .Fruta, consumirAte: Date(), units: 3, weight: nil)])
//}
