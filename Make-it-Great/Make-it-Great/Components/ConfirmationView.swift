//
//  ConfirmationView.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 29/10/24.
//

import SwiftUI

struct ConfirmationView: View {
    
    @Binding var isRemoved: Bool
    @Binding var selectedItems: Set<Food>
    @Binding var showingConfirmation: Bool
    
    var deleteAction: () -> Void
    
    var body: some View {
        
        VStack() {
            
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

            
            
//                .labelStyle(.iconOnly)
            
//            Button("Cancelar", systemImage: "nosign") {
//                showingConfirmation = false
//            }
//            .frame(maxWidth: .infinity)
//            .padding()
//            .foregroundColor(.black)
////            .bold()
//            .background(Color.white)
//            .cornerRadius(8)
            
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
           
            
            
          
            //.ignoresSafeArea()
         
        }
        .frame(maxWidth: .infinity)
        .padding()
        
//        .background(Color.accentColor)
        .background(Color(uiColor: .systemGray4))
        .cornerRadius(12)
        .shadow(radius: 10)
//        .blur(radius: showingConfirmation ? 3 : 0)
        
        /*.transition(.scale)*/ // Transição para animação de entrada/saída
        //.frame(width: 500) // Largura do retângulo
        //.frame(maxWidth: .infinity, maxHeight: .infinity)
        //.border(Color.black, width: 1)
//        .onTapGesture {
//            //Do nothing
//        }

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
