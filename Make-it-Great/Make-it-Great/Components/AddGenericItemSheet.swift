//
//  SwiftUIView.swift
//  Make-it-Great
//
//  Created by João Pedro Albuquerque on 01/10/24.
//

import SwiftUI
import UIKit
import SwiftData

struct AddGenericItem: View {
    
    @Environment(\.modelContext) var context
    @Query var items: [ItemModel]
    
    @Binding var isPresented: Bool

    @State var quantidade: String = ""
    @State var nome: String = ""
    @State var emoji: String = ""
    @State var isEmojiPickerShowing = false
    @State var dataInicio = Calendar.current.startOfDay(for: Date())
    @State var dataFim = Calendar.current.startOfDay(for: Date())
    @State var diffInDays: Int = 0
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
        VStack {
            HStack{
                Button {
                    isPresented = false
                } label: {
                    Text("Cancelar")
                        .foregroundStyle(.purpleItens)
                }
                Spacer()
                Button {
                    if (quantidade == "") {
                        errorMessage = "A quantidade não pode ser 0."
                    } else {
//                        _ = AppNotification(dataFim: $dataFim, identifier: $dataFim, item: .constant(ItemModel(nome: nome, emoji: emoji, consumirAte: dataFim, quantity: quantidade)))
                        
                        try! context.insert(ItemModel(nome: nome, emoji: emoji, consumirAte: dataFim, quantity: quantidade))
                        errorMessage = "\(items.count)"
                        isPresented = false
                        
                    }
                } label: {
                    Text("Adicionar")
                        .foregroundStyle(.purpleItens)
                }
            }
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
            
            VStack(alignment: .leading) {
                //Text("Adicionar Item")
                
                
                VStack {
                    HStack(spacing: 20) {
                        Text("Nome")
                        
                        TextField("Nome do alimento", text: $nome)
                            .foregroundStyle(.purpleItens)
                        // .textFieldStyle(.roundedBorder)
                        // .background(Color(.systemGray6))
                        //.cornerRadius(10)
                    }
                    .padding(.bottom, 11)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 1)
                            .foregroundStyle(.gray.opacity(0.2)),
                        alignment: .bottom
                    )
                    HStack(spacing: 20) {
                        Text("Quantidade")
                        
                        TextField("Quantidade", text: $quantidade)
                            .foregroundStyle(.purpleItens)
                        // .textFieldStyle(.roundedBorder)
                        // .background(Color(.systemGray6))
                        //.cornerRadius(10)
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
                                Text("🍎")
                                    .font(.system(size: 40))
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
                    
//                    HStack {
//                        Text("Tipo de Contagem:")
//                        Spacer()
//                        Picker("Tipo de Contagem", selection: $tipoQuantidade){
//                            ForEach(CountType.allCases, id: \.self){
//                                contType in
//                                Text(verbatim: "\(contType)")
//                            }
//                        }
//                        .tint(.purpleItens)
//                    }
//                    .padding(.top, 11)
//                    .padding(.bottom, 11)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 20)
//                            .frame(height: 1)
//                            .foregroundStyle(.gray.opacity(0.2)),
//                        alignment: .bottom
//                    )
//                    VStack {
//                        
//                        switch tipoQuantidade {
//                        case .Peso:
//                            VStack(alignment: .leading) {
//                                HStack {
//                                    Text("Quantidade")
//                                    TextField("Contador", value: $peso, formatter: numberFormatter)
//                                        .textFieldStyle(.roundedBorder)
//                                        .multilineTextAlignment(.trailing)
//                                        .keyboardType(.decimalPad)
//                                        .foregroundStyle(.purpleItens)
//                                    Text("kg")
//                                        .foregroundStyle(.purpleItens)
//                                }
//                            }
//                        case .Unidade:
//                            HStack {
//                                Text("Quantidade")
//                                TextField("Contador", value: $unidades, formatter: NumberFormatter())
//                                    .multilineTextAlignment(.trailing)
//                                    .textFieldStyle(.roundedBorder)
//                                    .keyboardType(.numberPad)
//                                    .padding(.trailing, 5)
//                                    .foregroundStyle(.purpleItens)
//                                HStack(spacing: 20) {
//                                    Button {
//                                        if unidades != 0 {
//                                            unidades -= 1
//                                        }
//                                        peso = 0
//                                    } label: {
//                                        Text("-").font(.system(size: 25))
//                                            .foregroundStyle(.purpleItens)
//                                    }
//                                    Text("|").font(.system(size: 15))
//                                        .foregroundStyle(.gray)
//                                    Button {
//                                        unidades += 1
//                                        peso = 0
//                                    } label: {
//                                        Text("+").font(.system(size: 25))
//                                            .foregroundStyle(.purpleItens)
//                                    }
//                                }
//                                .padding(.horizontal, 15)
//                                .background(RoundedRectangle(cornerRadius: 8)
//                                    .fill(.gray.opacity(0.18)))
//                            }
//                        }
//                        
//                    }
//                    .padding(.top, 11)
//                    .padding(.bottom, 11)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 20)
//                            .frame(height: 1)
//                            .foregroundStyle(.gray.opacity(0.2)),
//                        alignment: .bottom
//                    )
                    // Exibição da mensagem de erro
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.subheadline)
                            .padding(.top, 5)
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Período para consumo")
                            Spacer()
                            let diffInDays = Calendar.current.dateComponents([.day], from: dataInicio, to: dataFim).day ?? 0
                            if diffInDays > 0 {
                                if diffInDays == 1 {
                                    Text("1 dia")
                                        .foregroundStyle(.purpleItens)
                                } else {
                                    Text("\(diffInDays) dias")
                                        .foregroundStyle(.purpleItens)
                                }
                            } else if diffInDays < 0 {
                                Text("Data inconsistente!")
                                    .foregroundStyle(.purpleItens)
                            } else {
                                Text("Hoje")
                                    .foregroundStyle(.purpleItens)
                            }
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
                            .padding(.leading, 16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(height: 1)
                                    .foregroundStyle(.gray.opacity(0.2)),
                                alignment: .bottom
                            )
                        DatePicker("Data de fim", selection: $dataFim, displayedComponents: .date)
                            .padding(.bottom, 11)
                            .padding(.leading, 16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(height: 1)
                                    .foregroundStyle(.gray.opacity(0.2)),
                                alignment: .bottom
                            )
                    }
                    
                    
                    Spacer()
                    
                    //            HStack{
                    //                Text("Categoria")
                    //                Picker("Categoria", selection: $categoria){
                    //                    ForEach(FoodType.allCases, id: \.self) {
                    //                        food in
                    //                        Text(verbatim: "\(food)")
                    //                    }
                    //                }
                    //            }
                }
                
                .padding()
                .sheet(isPresented: $isEmojiPickerShowing) {
                    EmojiPickerView(selected: $emoji, showingEmojiPicker: $isEmojiPickerShowing)
                }
                .presentationDetents([.fraction(0.75), .fraction(0.85)])
                
            }
        }
    }
    
    //#Preview {
    //    AddItem(isPresented: true)
    //}
    
//    struct FormView_Previews: PreviewProvider {
//        static var previews: some View {
//            AddItem(isPresented: .constant(true), food: .constant(.Fruta))
//        }
//    }
}
