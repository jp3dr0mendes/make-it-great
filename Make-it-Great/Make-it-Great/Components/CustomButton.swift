//
//  CustomButton.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 07/10/24.
//

import SwiftUI

struct AddButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 361, height: 50)
            .background(configuration.isPressed ? Color.red : Color.gray, in: RoundedRectangle(cornerRadius: 10))
    
//            .animation(Animation.easeIn(duration: 0.2))
//            .onLongPressGesture {
//                withAnimation(.easeIn(duration: 0.5)) {
//                    
//                }
//            }
            //.cornerRadius(8)
        
    }

}


struct ButtonView: View {
    @Binding var isRemoved: Bool 
    @Binding var selectedItems: Set<Food>
    @State private var showingConfirmation = false
    
    
    var deleteAction: () -> Void
//    @Binding var isPresentedSheet: Bool
    
//    @Binding var isAnimating: Bool
    
    var body: some View {
        
        
        ZStack {
            
            Button(action: {
                
                showingConfirmation = true
                
            }) {
                
                HStack {
                    Image(systemName: "trash")
                        .foregroundColor(.white)
                    Text("Remove Selected Food")
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                }
            }
            //            .disabled(true)
            .buttonStyle(AddButtonStyle())
            .disabled(selectedItems.isEmpty)
            .overlay (
                
                Group {
                    if showingConfirmation {
                        ConfirmationDialog
                    }
        
                }
            )
            
        }
    }

    private var ConfirmationDialog: some View {
        
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
                
            }
        
        }
        .padding()
        .background(Color.purpleItens)
        .cornerRadius(12)
        .shadow(radius: 10)
       
//        .transition(.scale) // Transição para animação de entrada/saída
//        .frame(width: 500) // Largura do retângulo
//        .frame(maxWidth: .infinity, maxHeight: .infinity)

    }

    }
    

//#Preview {
//    @Previewable @State var isPresentedSheet: Bool = false
//    ButtonView(isPresentedSheet: $isPresentedSheet)
//}
#Preview {
    MainScreenView()
        .modelContainer(for: [Food.self])
}
