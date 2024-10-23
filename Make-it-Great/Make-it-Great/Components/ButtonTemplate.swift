//
//  ButtonTemplate.swift
//  Make-it-Great
//
//  Created by Vinicius Gabriel on 23/10/24.
//

import SwiftUI

struct ButtonTemplate: View {
    @Binding var buttonText: String
    @Binding var buttonColor: Color
    var body: some View {
        Button(action: {
            
        }, label: {
            Text(buttonText)
        })
        .frame(maxWidth: .infinity)
        .foregroundStyle(.white)
        .background(.purpleItens)
    }
}

#Preview {
    ButtonTemplate(buttonText: .constant("Começar"), buttonColor: .constant(.purpleItens))
}
