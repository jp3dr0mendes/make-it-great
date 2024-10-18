//
//  EditItemSheet.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 17/10/24.
//

import SwiftUI
import UIKit
import SwiftData

struct EditItemSheet: View {
    
    @Environment(\.modelContext) var context
    
    @Query(sort: \Food.nome) var foods: [Food]

    @Binding var isPresented: Bool
    @Binding var storage: StorageType
    
    // Aqui, recebemos o item existente (se for edição), caso contrário, será um novo item
    @State var item: Food?
    
    @State var nome: String = ""
    @State var emoji: String = ""
    @State var isEmojiPickerShowing = false
    @State var dataInicio: Date = Date(timeInterval: 7*60*60*24, since: Date.now)
    @State var dataFim: Date = Date(timeInterval: 7*60*60*24, since: Date.now)
    @State var categoria: FoodType = .Bebida
    @State var tipoQuantidade: CountType = .Unidade
    
    @State var peso: Float = 0
    @State var unidades: Int = 0
    @State var errorMessage: String = ""
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    var body: some View {
        HStack {
            Button("Cancelar") {
                isPresented = false
            }
            Spacer()
            Button(item != nil ? "Salvar" : "Adicionar") {
                // Verifica se os valores são válidos
                if ((tipoQuantidade == .Peso && peso != 0) || tipoQuantidade == .Unidade && unidades > 0) {
                    
                    if let item = item {
                        
                        let newItem = Food(nome: nome, storage: storage, type: categoria, consumirAte: dataInicio, units: unidades, weight: peso)
                        
                        
                        
                        
                        // Atualizar item existente
//                        item.nome = nome
//                        item.storage = storage
//                        item.type = categoria // Atribuindo diretamente como FoodType
//                        item.consumirAte = dataInicio
                        
                        switch tipoQuantidade {
                        case .Peso:
                            item.weight = peso
                            item.units = nil
                        case .Unidade:
                            item.units = unidades
                            item.weight = nil
                        }
                        
                        // Salvar as mudanças no contexto
                        do {
                            context.insert(newItem)
                            try context.save()
                        } catch {
                            print("Erro ao salvar as mudanças: \(error)")
                        }
                    } else {
                        // Criar novo item
                        switch tipoQuantidade {
                        case .Peso:
                            context.insert(Food(nome: nome, storage: storage, type: categoria, consumirAte: dataInicio, units: nil, weight: peso))
                        case .Unidade:
                            context.insert(Food(nome: nome, storage: storage, type: categoria, consumirAte: dataInicio, units: unidades, weight: nil))
                        }
                    }
                    
                    isPresented = false
                } else {
                    errorMessage = "Valor inválido!"
                }
            }
        }
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
        
        VStack(alignment: .leading) {
            VStack {
                HStack(spacing: 20) {
                    Text("Nome")
                    TextField("Nome do alimento", text: $nome)
                }
                .padding(.bottom, 11)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 1)
                        .foregroundStyle(.gray.opacity(0.2)),
                    alignment: .bottom
                )
            }
            
            HStack(spacing: 20) {
                Text("Emoji")
                Spacer()
                Button {
                    isEmojiPickerShowing = true
                } label: {
                    if emoji == "" {
                        Image(systemName: "carrot.fill")
                    } else {
                        Image(systemName: emoji)
                    }
                }
            }

            HStack {
                Text("Tipo de Contagem:")
                Spacer()
                Picker("Tipo de Contagem", selection: $tipoQuantidade) {
                    ForEach(CountType.allCases, id: \.self) { contType in
                        Text(verbatim: "\(contType)")
                    }
                }
                .tint(.purpleItens)
            }
            .padding(.top, 11)
            .padding(.bottom, 11)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 1)
                    .foregroundStyle(.gray.opacity(0.2)),
                alignment: .bottom
            )
            
            VStack(alignment: .leading) {
                DatePicker("Data de início", selection: $dataInicio, displayedComponents: .date)
                    .padding(.bottom, 11)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 1)
                            .foregroundStyle(.gray.opacity(0.2)),
                        alignment: .bottom
                    )
                DatePicker("Data de fim", selection: $dataFim, displayedComponents: .date)
                    .padding(.bottom, 11)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 1)
                            .foregroundStyle(.gray.opacity(0.2)),
                        alignment: .bottom
                    )
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            
            VStack {
                switch tipoQuantidade {
                case .Peso:
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Quantidade")
                            TextField("Contador", value: $peso, formatter: numberFormatter)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.decimalPad)
                            Text("kg")
                        }
                        Text(errorMessage)
                            .foregroundStyle(.red)
                    }
                case .Unidade:
                    HStack {
                        Text("Quantidade")
                        TextField("Contador", value: $unidades, formatter: NumberFormatter())
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                        HStack(spacing: 7) {
                            Button {
                                if unidades != 0 {
                                    unidades -= 1
                                }
                                peso = 0
                            } label: {
                                Text("-").font(.system(size: 20))
                            }
                            Text("|").font(.system(size: 8))
                                .foregroundStyle(.gray)
                            Button {
                                unidades += 1
                                peso = 0
                            } label: {
                                Text("+").font(.system(size: 20))
                            }
                        }
                        .padding(.horizontal, 15)
                        .background(RoundedRectangle(cornerRadius: 8)
                            .fill(.gray.opacity(0.12)))
                    }
                }
            }
        }
        .padding()
        .onAppear {
            // Se for edição, carrega os valores existentes do item
            if let item = item {
                
                
//                nome = item.nome ?? ""
//                storage = item.storage
//                categoria = item.type // Assume que tipo é FoodType
//                dataInicio = item.consumirAte ?? Date()
//                tipoQuantidade = item.units != nil ? .Unidade : .Peso
//                peso = item.weight ?? 0
//                unidades = item.units ?? 0
            }
        }
        .sheet(isPresented: $isEmojiPickerShowing) {
            EmojiPickerView(selected: $emoji)
        }
    }
}

#Preview {
    @Previewable @State var isPresented: Bool = false
    @Previewable @State var storage: StorageType = .cabinet
    EditItemSheet(isPresented: $isPresented, storage: $storage) // Corrigido para EditItemSheet
}

//struct FormView_Previews: PreviewProvider {
//  static var previews: some View {
//      EditItemSheet(isPresented: .constant(true), storage: .constant(.cabinet))
//  }
//}
