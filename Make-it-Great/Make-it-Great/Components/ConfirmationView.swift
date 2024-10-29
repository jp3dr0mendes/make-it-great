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
                .foregroundColor(.white) // Cor personalizada do texto
            
            HStack {
                Button("Confirmar", systemImage: "checkmark") {
                    deleteAction()
                    showingConfirmation = false
                }
                .foregroundColor(.black)
                .padding()
                .background(Color.green)
                .cornerRadius(8)
//                .labelStyle(.iconOnly)
                
                Button("Cancelar", systemImage: "nosign") {
                    showingConfirmation = false
                }
                .foregroundColor(.black)
                .padding()
                .background(Color.red)
                .cornerRadius(8)
                .ignoresSafeArea()
                
            }
        }
        .padding()
        .background(Color.purpleItens)
        .cornerRadius(12)
        .shadow(radius: 10)
       
        .transition(.scale) // Transição para animação de entrada/saída
        .frame(width: 500) // Largura do retângulo
        .frame(maxWidth: .infinity, maxHeight: .infinity)

    }
}

#Preview {
    @Previewable @State var isRemoved: Bool = false
    @Previewable @State var selectedItems: Set<Food> = []
    @Previewable @State var showingConfirmation: Bool = false
    ConfirmationView(isRemoved: $isRemoved, selectedItems: $selectedItems, showingConfirmation: $showingConfirmation, deleteAction: {
        
    })
}
