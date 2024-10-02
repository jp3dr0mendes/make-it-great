//
//  SwiftUIView.swift
//  Make-it-Great
//
//  Created by João Pedro Albuquerque on 01/10/24.
//

import SwiftUI

struct AddItem: View {
    @Binding var isPresented: Bool
    
    @State var nome: String = ""
    @State var data: Date = Date(timeInterval: 7*60*60*24, since: Date.now)
    @State var categoria: FoodType = .Bebida
    @State var tipoQuantidade: CountType = .Unidade
    
    @State var count = 0
//    @State var contagem: CountType = .Unit

    var body: some View {
        
        HStack{
            Button("Adicionar"){
                isPresented = false
            }
            
            Button("Cancelar"){
                isPresented = false
            }
        }
        
        VStack{
            Text("Adicionar Item")
            
            VStack{
                
                HStack{
                    Text("Nome")
                    TextField("nome", text: $nome)

                        .textFieldStyle(.roundedBorder)
//                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                }
                
            }

            HStack{

                Text("Tipo de Contagem:")
                Picker("Tipo de Contagem", selection: $tipoQuantidade){
                    ForEach(CountType.allCases, id: \.self){
                        contType in
                        Text(verbatim: "\(contType)")
                    }
                }
            }
            
            
//            TextField("Contador", value: $count, formatter: NumberFormatter())
//                            .textFieldStyle(.roundedBorder)
            
            VStack{
                
                switch tipoQuantidade {
                case .Peso:
                    HStack{
                        
                        Text("Quantidade")
                        
                        TextField("Contador", value: $count, formatter: NumberFormatter())
                            .textFieldStyle(.roundedBorder)
                        Text("kg")
                    }
                case .Unidade:
                    HStack{
                        
                        Text("Quantidade")
                        
                        Button("-") {
                            count -= 1
                        }

                        TextField("Contador", value: $count, formatter: NumberFormatter())
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                            .disabled(count <= 0)
                        
                        Button("+") {
                            count += 1
                        }

                    }
                }
            }
            
            HStack{
                Text("Categoria")
                Picker("Categoria", selection: $categoria){
                    ForEach(FoodType.allCases, id: \.self) {
                        food in
                        Text(verbatim: "\(food)")
                    }
                }
            }
            
            DatePicker("Consumir até", selection: $data, displayedComponents: .date)
        }
    }
}

//#Preview {
//    AddItem(isPresented: true)
//}
