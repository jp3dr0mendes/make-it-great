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
    @Binding var storage: StorageType
    
    @State var nome: String = ""
    @State var emoji: String = ""
    @State var isEmojiPickerShowing = false
    @State var dataInicio: Date = Date(timeInterval: 7*60*60*24, since: Date.now)
    @State var dataFim: Date = Date(timeInterval: 7*60*60*24, since: Date.now)
    @State var categoria: FoodType = .Bebida
    @State var tipoQuantidade: CountType = .Unidade
    @State var diffInDays: Int = 0
    
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
        
        HStack{
            Button("Cancelar"){
                isPresented = false
            }
            Spacer()
            Button("Adicionar"){
                let diff = Calendar.current.dateComponents([.day], from: dataInicio, to: dataFim).day ?? 0
                if diff > -1 && dataFim != dataInicio {
                    if diff == 0 {
                        diffInDays = 1
                    } else {
                        diffInDays = diff + 1
                    }
                } else {
                    diffInDays = diff
                }
                print(diffInDays)
                if ((tipoQuantidade == .Peso && peso != 0) || tipoQuantidade == .Unidade && unidades > 0) {
                    switch tipoQuantidade {
                    case .Peso:
                        context.insert(Food(nome: nome, storage: storage, type: categoria, consumirAte: diffInDays, units: nil, weight: peso))
                    case .Unidade:
                        context.insert(Food(nome: nome, storage: storage, type: categoria, consumirAte: diffInDays, units: unidades, weight: nil))
                    }
                    
                    isPresented = false
                } else {
                    errorMessage = "Valor inválido!"
                }
            }
        }
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
        
        VStack(alignment: .leading) {
            //Text("Adicionar Item")
            
            
            VStack {
                HStack(spacing: 20) {
                    Text("Nome")
                    
                    TextField("Nome do alimento", text: $nome)
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
            VStack(alignment: .leading) {
                HStack {
                    Text("Período")
                    Spacer()
                    Button {
                        let diff = Calendar.current.dateComponents([.day], from: dataInicio, to: dataFim).day ?? 0
                        if diff > -1 && dataFim != dataInicio {
                            if diff == 0 {
                                diffInDays = 1
                            } else {
                                diffInDays = diff + 1
                            }
                        } else {
                            diffInDays = diff
                        }
                        print(diffInDays)
                        
                    } label: {
                        let diffInDays = Calendar.current.dateComponents([.day], from: dataInicio, to: dataFim).day ?? 0
                        if diffInDays > 0 {
                            if diffInDays == 1 {
                                Text("Amanhã")
                            } else {
                                Text("\(diffInDays + 1) dias")
                            }
                        } else if diffInDays < 0 {
                            Text("Data inconsistente!")
                        } else {
                            Text("Today")
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
            }
            
            
//            TextField("Contador", value: $count, formatter: NumberFormatter())
//                            .textFieldStyle(.roundedBorder)
            
            VStack {
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
                        TextField("Contador", value: $unidades, formatter: NumberFormatter())
                            .multilineTextAlignment(.trailing)
                            //.textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                            //.disabled(unidades == 0)
                            .foregroundStyle(Color(.purpleItens))
                        HStack(spacing: 7) {
                            Button {
                                if unidades != 0 {
                                    unidades -= 1
                                }
                                peso = 0
                            } label: {
                                Text("-")
                                    .font(.system(size: 20))
                            }
                            .foregroundStyle(Color(.purpleItens))
                            Text("|")
                                .font(.system(size: 8))
                                .foregroundStyle(.gray)
                            Button {
                                unidades += 1
                                peso = 0
                            } label : {
                                Text("+")
                                    .font(.system(size: 20))
                            }
                            .foregroundStyle(Color(.purpleItens))
                        }
                        .padding(.horizontal, 15)
                        .background(RoundedRectangle(cornerRadius: 8)
                            .fill(.gray.opacity(0.12)))

                    }
                }
            }
            
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
            EmojiPickerView(selected: $emoji)
        }
    }
}

//#Preview {
//    AddItem(isPresented: true)
//}

struct FormView_Previews: PreviewProvider {
  static var previews: some View {
      AddItem(isPresented: .constant(true), storage: .constant(.cabinet))
  }
}
