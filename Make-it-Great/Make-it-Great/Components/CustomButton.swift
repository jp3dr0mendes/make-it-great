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
    @Binding var showingConfirmation: Bool

    
    
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
            
//            
//            if showingConfirmation {
//                ConfirmationDialog
//            }
//            .overlay (
//                
//                Group {
//                    if showingConfirmation {
//                        ConfirmationDialog
//                    }
//        
//                }
//            )
            
        }
//        .overlay (
//            Group {
//                if showingConfirmation {
//                    ConfirmationView(isRemoved: $isRemoved, selectedItems: $selectedItems, showingConfirmation: $showingConfirmation, deleteAction: {
//                        
//                    })
//                }
//            }
//        )
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
