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
    
            
            .animation(Animation.easeIn(duration: 0.2))
//            .onLongPressGesture {
//                withAnimation(.easeIn(duration: 0.5)) {
//                    
//                }
//            }
            //.cornerRadius(8)
        
    }
}


struct ButtonView: View {
    
    @Binding var selectedItems: Set<Food>
    
    var deleteAction: () -> Void
//    @Binding var isPresentedSheet: Bool
    
//    @Binding var isAnimating: Bool
    
    var body: some View {
        ZStack {
            Button(action: {
                deleteAction()
                //Acho que posso usar isso aqui para fazer as listas desaparecerem quando aperta o botao:
//                withAnimation(.easeInOut(duration: 4)) {
//                    
//                }git 
                
//                isPresentedSheet = true
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

       
            
//            Button( action: {
//        
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                    withAnimation(.easeIn(duration: 0.5)) {
//                        isPresentedSheet = true
//                    }
//                }
//                
//            }) {
//                Text("Remove Food")
//                    .font(.system(size: 14))
//                    .foregroundColor(.white)
//            }
            
        }
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
