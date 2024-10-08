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
            .background(configuration.isPressed ? Color.red : Color.gray)
            .animation(Animation.easeIn(duration: 0.5))
//            .onLongPressGesture {
//                withAnimation(.easeIn(duration: 0.5)) {
//                    
//                }
//            }
            .cornerRadius(8)
        
    }
}


struct ButtonView: View {
    
@Binding var isPresentedSheet: Bool
    
//    @Binding var isAnimating: Bool
    
    var body: some View {
        ZStack {
            Button(action: {
                isPresentedSheet = true
            }) {
                Text("Remove From Food")
                    .font(.system(size: 14))
                    .foregroundColor(.white)
            }
//            .disabled(true)
            .buttonStyle(AddButtonStyle())
          
       
            
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

#Preview {
    @Previewable @State var isPresentedSheet: Bool = false
    ButtonView(isPresentedSheet: $isPresentedSheet)
}
