//
//  SwiftUIView.swift
//  Make-it-Great
//
//  Created by João Pedro Albuquerque on 01/10/24.
//

import SwiftUI

struct AddItem: View {
    @Environment(\.modelContext) var context
    



    @Binding var isPresented: Bool
    @Binding var storage: StorageType
    
    @State var nome: String = ""
    @State var data: Date = Date(timeInterval: 7*60*60*24, since: Date.now)
    @State var categoria: FoodType = .Bebida
    @State var tipoQuantidade: CountType = .Unidade
    
    @State var peso: Float = 0
    @State var unidades: Int = 0


    var body: some View {
        
        HStack{
            Button("Adicionar"){

                switch tipoQuantidade {
                case .Peso:
                    context.insert(Food(nome: nome, storage: storage, type: categoria, consumirAte: data, units: nil, weight: peso))
                case .Unidade:
                    context.insert(Food(nome: nome, storage: storage, type: categoria, consumirAte: data, units: unidades, weight: nil))
                }
                
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
                        
                        TextField("Contador", value: $peso, formatter: NumberFormatter())
                            .textFieldStyle(.roundedBorder)
                        Text("kg")
                    }
                case .Unidade:
                    HStack{
                        
                        Text("Quantidade")
                        
                        Button("-") {
                            unidades -= 1
                        }

                        TextField("Contador", value: $unidades, formatter: NumberFormatter())
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                            .disabled(unidades == 0)
                        
                        Button("+") {
                            unidades += 1
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
            
            
//            TextField("Contador", value: $count, formatter: NumberFormatter())
//                            .textFieldStyle(.roundedBorder)
            
            VStack{
                
                switch tipoQuantidade {
                case .Peso:
                    HStack{
                        
                        Text("Quantidade")
                        
                        TextField("Contador", value: $peso, formatter: NumberFormatter())
                            .textFieldStyle(.roundedBorder)
                        Text("kg")
                    }
                case .Unidade:
                    HStack{
                        
                        Text("Quantidade")
                        
                        Button("-") {
                            unidades -= 1
                        }

                        TextField("Contador", value: $unidades, formatter: NumberFormatter())
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                            .disabled(unidades == 0)
                        
                        Button("+") {
                            unidades += 1
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
            
            
            //            TextField("Contador", value: $count, formatter: NumberFormatter())
            //                            .textFieldStyle(.roundedBorder)
            
            VStack{
                
                switch tipoQuantidade {
                case .Peso:
                    HStack{
                        
                        Text("Quantidade")
                        
                        TextField("Contador", value: $peso, formatter: NumberFormatter())
                            .textFieldStyle(.roundedBorder)
                        Text("kg")
                    }
                case .Unidade:
                    HStack{
                        
                        Text("Quantidade")
                        
                        Button("-") {
                            unidades -= 1
                        }
                            .keyboardType(.numberPad)
                            
                            Button("+") {
                                unidades -= 1
                            }
                            
                            TextField("Contador", value: $unidades, formatter: NumberFormatter())
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.numberPad)
                                .disabled(unidades == 0)
                            
                            Button("+") {
                                unidades += 1
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


