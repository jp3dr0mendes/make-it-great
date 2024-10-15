//
//  SelectButton.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 15/10/24.
//

import SwiftUI

struct SelectButton: View {
    var body: some View {
        
        Button(action: {
            
            //Navegar para alguma tela
            
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
        
    }
}

#Preview {
    SelectButton()
}
