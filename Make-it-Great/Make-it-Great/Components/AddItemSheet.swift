//
//  SwiftUIView.swift
//  Make-it-Great
//
//  Created by João Pedro Albuquerque on 01/10/24.
//

import SwiftUI

struct AddItem: View {
    
    @State var nome: String = ""
    @State var data: Date
    @State var categoria: FoodType = .Bebida
//    @State var contagem: CountType = .Unit

    var body: some View {
        Text("Nome")
        TextField("Teste", text: $nome)
        
        Text("Quantidade")
        
        Text("Tipo de Contagem")
//        Picker("Tipo de Contagem", selection: $contagem){
//            ForEach(CountType.allCases, id: \.self){
//                cont in
//                Text(verbatim: "\(cont)")
//            }
//        }
        
        Text("Categoria")
        Picker("Categoria", selection: $categoria){
            ForEach(FoodType.allCases, id: \.self) {
                food in
                Text(verbatim: "\(food)")
            }
        }
        
        DatePicker("Consumir até", selection: $data, displayedComponents: .date)
    }
}

#Preview {
    AddItem(data: Date(timeInterval: 7*60*60*24, since: Date.now))
}
