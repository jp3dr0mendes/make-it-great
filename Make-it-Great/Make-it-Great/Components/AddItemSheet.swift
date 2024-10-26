//
//  SwiftUIView.swift
//  Make-it-Great
//
//  Created by João Pedro Albuquerque on 01/10/24.
//

import SwiftUI
import UIKit
import SwiftData

struct AddItem: View {
    
    @Environment(\.modelContext) var context
    
    @Binding var isPresented: Bool
    @Binding var food: FoodType
    
    @State var nome: String = ""
    @State var emoji: String = ""
    @State var isEmojiPickerShowing = false
    @State var dataInicio = Calendar.current.startOfDay(for: Date())
    @State var dataFim = Calendar.current.startOfDay(for: Date())
    //    @State var dataInicio: Date = Date(timeInterval: 7*60*60*24, since: Date.now)
    //    @State var dataFim: Date = Date(timeInterval: 7*60*60*24, since: Date.now)
    @State var diffInDays: Int = 0
    //@State var categoria: FoodType = .Fruta
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
                    if (tipoQuantidade == .Peso && peso == 0) || (tipoQuantidade == .Unidade && unidades == 0) {
                        errorMessage = "A quantidade não pode ser 0."
                    } else {
                        switch tipoQuantidade {
                        case .Peso:
                            context.insert(Food(nome: nome, emoji: emoji, storage: .refrigerator, type: food, consumirAte: dataFim, units: nil, weight: peso))
                        case .Unidade:
                            context.insert(Food(nome: nome, emoji: emoji, storage: .cabinet, type: food, consumirAte: dataFim, units: unidades, weight: nil))
                        }
                        
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
                        Text("Emoji")
                        Spacer()
                        Button {
                            isEmojiPickerShowing = true
                        } label: {
                            if emoji == "" {
                                if food == .Fruta {
                                    Text("🍎")
                                        .font(.system(size: 40))
                                } else if food == .Vegetal {
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
                        Picker("Tipo de Contagem", selection: $tipoQuantidade){
                            ForEach(CountType.allCases, id: \.self){
                                contType in
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
                    VStack {
                        
                        switch tipoQuantidade {
                        case .Peso:
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Quantidade")
                                    TextField("Contador", value: $peso, formatter: numberFormatter)
                                        .textFieldStyle(.roundedBorder)
                                        .multilineTextAlignment(.trailing)
                                        .keyboardType(.decimalPad)
                                        .foregroundStyle(.purpleItens)
                                    Text("kg")
                                        .foregroundStyle(.purpleItens)
                                }
                            }
                        case .Unidade:
                            HStack {
                                Text("Quantidade")
                                TextField("Contador", value: $unidades, formatter: NumberFormatter())
                                    .multilineTextAlignment(.trailing)
                                    .textFieldStyle(.roundedBorder)
                                    .keyboardType(.numberPad)
                                    .padding(.trailing, 5)
                                    .foregroundStyle(.purpleItens)
                                HStack(spacing: 20) {
                                    Button {
                                        if unidades != 0 {
                                            unidades -= 1
                                        }
                                        peso = 0
                                    } label: {
                                        Text("-").font(.system(size: 25))
                                            .foregroundStyle(.purpleItens)
                                    }
                                    Text("|").font(.system(size: 15))
                                        .foregroundStyle(.gray)
                                    Button {
                                        unidades += 1
                                        peso = 0
                                    } label: {
                                        Text("+").font(.system(size: 25))
                                            .foregroundStyle(.purpleItens)
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
    
    struct FormView_Previews: PreviewProvider {
        static var previews: some View {
            AddItem(isPresented: .constant(true), food: .constant(.Fruta))
        }
    }
}
