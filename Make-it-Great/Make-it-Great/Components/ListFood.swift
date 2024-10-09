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
    var comida: Food
    var body: some View {
        
        VStack{
        
            HStack () {
                
                Spacer()
                
                Image(systemName: "cup.and.saucer.fill") //Preciso fazer um model para colocar a imagem certa aqui
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    //.foregroundColor(.yellow)
                    .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                    .shadow(radius: 10)
                    
                
                VStack (alignment: .leading) {
                    Text(comida.nome)
                        .font(.headline)
                    
                    Text("1x")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        
                }
                
//                Button("Apagar"){
//                    context.delete(comida)
//                }
                
                Spacer()
                
                Text("30 dias para o consumo") //Isso aqui pode mudar muito, deve haver um tratamento no que o sua
                    .font(.caption)
                    .multilineTextAlignment(.trailing)
                Spacer()
            }
            
            Divider() //Linha horizontal que divide os elementos
            
        }
    }
}

#Preview {
    ListFood(comida: Food(nome: "Visualização do Item", storage: .refrigerator, type: .Bebida, consumirAte: Date(timeInterval: 7*60*60*24, since: Date.now), units: 2, weight: nil))
        .modelContainer(for: [Food.self])
}
