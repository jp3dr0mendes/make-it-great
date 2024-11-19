//
//  ConfirmationView.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 29/10/24.
//

import SwiftUI

struct ConfirmationView: View {
    
    @Binding var isRemoved: Bool
    @Binding var selectedItems: Set<ItemModel>
    @Binding var showingConfirmation: Bool
    
    var deleteAction: () -> Void
    
    var body: some View {
        Spacer()
        VStack {
            
            Text("Excluir itens selecionados?")
                .font(.headline)
                .foregroundColor(.purpleItens) // Cor personalizada do texto
            
            Button(action: {
                deleteAction()
                showingConfirmation = false
            }) {
                Label("Confirmar", systemImage: "checkmark") // Adiciona a imagem de sistema junto com o texto
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.purpleItens)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
            }
            .contentShape(Rectangle()) // Expande a área clicável para o botão inteiro
            
            Button(action: {
                showingConfirmation = false
            }) {
                Label("Cancelar", systemImage: "nosign") // Adiciona a imagem de sistema junto com o texto
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.black)
                    .background(Color.white)
                    .cornerRadius(8)
            }
            .contentShape(Rectangle())
        }
        .frame(alignment: .bottom)
        .padding()
        .background(Color(uiColor: .systemGray4))
        .cornerRadius(12)
        .shadow(radius: 10)
    }
}

//#Preview {
//    @Previewable @State var isRemoved: Bool = false
//    @Previewable @State var selectedItems: Set<Food> = []
//    @Previewable @State var showingConfirmation: Bool = false
//    ConfirmationView(isRemoved: $isRemoved, selectedItems: $selectedItems, showingConfirmation: $showingConfirmation, deleteAction: {
//        
//    })
//}
