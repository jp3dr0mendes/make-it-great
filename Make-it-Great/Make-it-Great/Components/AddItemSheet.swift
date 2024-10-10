//
//  SwiftUIView.swift
//  Make-it-Great
//
//  Created by João Pedro Albuquerque on 01/10/24.
//

import SwiftUI
import SwiftData

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
    @State var errorMessage: String = ""
//    @State var contagem: CountType = .Unit
    let numberFormatter: NumberFormatter = {
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                formatter.minimumFractionDigits = 1  // Mínimo de 1 casa decimal
                formatter.maximumFractionDigits = 2  // Máximo de 2 casas decimais (ou ajuste conforme necessário)
                return formatter
    }()

    var body: some View {
        
//        VStack{
//            Text("\(isPresented)")
//            Text("\(storage)")
//            Text("\(nome)")
//            Text("\(data)")
//            Text("\(categoria)")
//            Text("\(tipoQuantidade)")
//            Text("\(peso)")
//            Text("\(unidades)")
//        }
        
        HStack{
            Button("Adicionar"){
                if ((tipoQuantidade == .Peso && peso != 0) || tipoQuantidade == .Unidade && unidades > 0) {
                    switch tipoQuantidade {
                    case .Peso:
                        context.insert(Food(nome: nome, storage: storage, type: categoria, consumirAte: data, units: nil, weight: peso))
                    case .Unidade:
                        context.insert(Food(nome: nome, storage: storage, type: categoria, consumirAte: data, units: unidades, weight: nil))
                    }
                    
                    isPresented = false
                } else {
                    errorMessage = "Valor inválido!"
                }
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
                    VStack(alignment: .leading) {
                        HStack{
                            
                            Text("Quantidade")
                            TextField("Contador", value: $peso, formatter: numberFormatter, onCommit: {
                                unidades = 0
                            })
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.decimalPad)
                            Text("kg")
                        }
                        Text(errorMessage)
                            .foregroundStyle(.red)
                    }
                case .Unidade:
                    HStack{
                        
                        Text("Quantidade")
                        
                        Button("-") {
                            if unidades != 0 {
                                unidades -= 1
                            }
                            peso = 0
                        }

                        TextField("Contador", value: $unidades, formatter: NumberFormatter())
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                            .disabled(unidades == 0)
                        
                        Button("+") {
                            unidades += 1
                            peso = 0
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
