//
//  SelectButton.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 15/10/24.
//

import SwiftUI

struct SelectButton: View {
    
    @Binding var showingButton: Bool
    
    var body: some View {
        
        HStack {
            
            Button(action: {
                
                withAnimation {
                    showingButton.toggle()
                    //print("toggle")
                }
                
            }) {
                Text("Select")
                    .padding()
                //.background(Color.white)
                    .font(.system(size: 15))
                    .foregroundColor(.purpleItens)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.purpleItens, lineWidth: 1)
                    .frame(width: 72, height: 36)
            )
            Spacer()
        }.padding(.leading, 22)
        
    }
}

#Preview {
    @Previewable @State var showignButton: Bool = false
    SelectButton(showingButton: $showignButton)
}

