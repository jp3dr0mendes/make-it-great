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
    
    //    @Query(sort: \Food.nome) var foods: [Food]
    
    @Binding var isPresented: Bool
    
    // Aqui, recebemos o item existente (se for edição), caso contrário, será um novo item
    @State var item: Food
    @Binding var selectedCategory: StorageType
    @State var nome: String
    @State var emoji: String
    @State var isEmojiPickerShowing = false
    @State var dataInicio = Calendar.current.startOfDay(for: Date())
    @State var dataFim: Date
    //    @State var dataInicio: Date = Date(timeInterval: 7*60*60*24, since: Date.now)
    //    @State var dataFim: Date = Date(timeInterval: 7*60*60*24, since: Date.now)
    
    @State var categoria: FoodType = .Bebida
    @State var tipoQuantidade: CountType
    
    @State var peso: Float
    @State var unidades: Int
    @State var errorMessage: String = ""
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button {
                    isPresented = false
                } label: {
                    Text("Cancelar")
                        .foregroundStyle(.purpleItens)
                }
                Spacer()
                Button {
                    Task {
                        item.nome = nome
                        item.emoji = emoji
                        item.consumirAte = dataFim
                        
                        switch tipoQuantidade{
                        case .Peso:
                            item.weight = peso
                            item.units = nil
                        case .Unidade:
                            item.units = unidades
                            item.weight = nil
                        }
                        
                        try context.save()
                        
                        isPresented = false
                    }
                } label: {
                    Text("Salvar")
                        .foregroundStyle(.purpleItens)
                }
            }
            // Verifica se os valores são válidos
            //                if ((item.weight != nil && item.weight != 0) || item.units != nil && item.units > 0) {
            //
            //                    if let item = item {
            //
            //                        let newItem = Food(nome: nome, storage: storage, type: categoria, consumirAte: dataInicio, units: unidades, weight: peso)
            //
            //
            //
            //
            //                        // Atualizar item existente
            ////                        item.nome = nome
            ////                        item.storage = storage
            ////                        item.type = categoria // Atribuindo diretamente como FoodType
            ////                        item.consumirAte = dataInicio
            //
            //                        switch tipoQuantidade {
            //                        case .Peso:
            //                            item.weight = peso
            //                            item.units = nil
            //                        case .Unidade:
            //                            item.units = unidades
            //                            item.weight = nil
            //                        }
            //
            //                        // Salvar as mudanças no contexto
            //                        do {
            //                            context.insert(newItem)
            //                            try context.save()
            //                        } catch {
            //                            print("Erro ao salvar as mudanças: \(error)")
            //                        }
            //                    } else {
            //                        // Criar novo item
            //                        switch tipoQuantidade {
            //                        case .Peso:
            //                            context.insert(Food(nome: nome, storage: storage, type: categoria, consumirAte: dataInicio, units: nil, weight: peso))
            //                        case .Unidade:
            //                            context.insert(Food(nome: nome, storage: storage, type: categoria, consumirAte: dataInicio, units: unidades, weight: nil))
            //                        }
            //                    }
            
            
            //                    isPresented = false
            //                } else {
            //                    errorMessage = "Valor inválido!"
            //                }
            //            }
            //        }
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
            
            VStack(alignment: .leading) {
                
                VStack {
                    HStack(spacing: 20) {
                        Text("Nome")
                        TextField("Nome do alimento", text: $nome)
                            .foregroundStyle(.purpleItens)
                    }
                    .padding(.bottom, 11)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 1)
                            .foregroundStyle(.gray.opacity(0.2)),
                        alignment: .bottom
                    )
                    HStack(spacing: 20) {
                        Text("Emoji")
                        Spacer()
                        Button {
                            isEmojiPickerShowing = true
                        } label: {
                            if emoji == "" {
                                if selectedCategory == .refrigerator {
                                    Text("🍎")
                                        .font(.system(size: 40))
                                } else if selectedCategory == .cabinet {
                                    Text("🥕")
                                        .font(.system(size: 40))
                                }
                            } else {
                                Text("\(emoji)")
                                    .font(.system(size: 40))
                            }
                        }
                    }
                    .padding(.top, 11)
                    .padding(.bottom, 11)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 1)
                            .foregroundStyle(.gray.opacity(0.2)),
                        alignment: .bottom
                    )
                    
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
                        HStack {
                            Text("Período")
                            Spacer()
                            Button {
                                
                            } label: {
                                let diffInDays = Calendar.current.dateComponents([.day], from: dataInicio, to: dataFim).day ?? 0
                                if diffInDays > 0 {
                                    if diffInDays == 1 {
                                        Text("1 dia")
                                    } else {
                                        Text("\(diffInDays) dias")
                                    }
                                } else if diffInDays < 0 {
                                    Text("Data inconsistente!")
                                } else {
                                    Text("Hoje")
                                }
                            }
                            .foregroundStyle(.purpleItens)
                        }
                        .padding(.bottom, 11)
                        .padding(.top, 11)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .frame(height: 1)
                                .foregroundStyle(.gray.opacity(0.2)),
                            alignment: .bottom
                        )
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
                                    .fill(.gray.opacity(0.18)))
                            }
                        }
                        
                    }
                    .padding(.top, 11)
                    .padding(.bottom, 11)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 1)
                            .foregroundStyle(.gray.opacity(0.2)),
                        alignment: .bottom
                    )
                    Spacer()
                }
                .padding()
                .sheet(isPresented: $isEmojiPickerShowing) {
                    EmojiPickerView(selected: $emoji, showingEmojiPicker: $isEmojiPickerShowing)
                }
                .presentationDetents([.fraction(0.75), .fraction(0.85)])
            }
        }
    }
}

//#Preview {
//    @Previewable @State var isPresented: Bool = false
//    @Previewable @State var storage: StorageType = .cabinet
//    @Previewable @State var comida: Food = Food(nome: "maca", storage: storage, type: .Fruta, consumirAte: Date(timeInterval: 7*60*60*24, since: Date.now), units: 1, weight: nil)
//    EditItemSheet(isPresented: $isPresented, storage: $storage, item: $comida) // Corrigido para EditItemSheet
//}

//struct FormView_Previews: PreviewProvider {
//  static var previews: some View {
//      EditItemSheet(isPresented: .constant(true), storage: .constant(.cabinet))
//  }
//}
