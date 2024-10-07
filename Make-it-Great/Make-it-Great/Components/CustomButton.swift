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
            .background(configuration.isPressed ? Color.green : Color.blue)
            .animation(Animation.easeIn(duration: 1))
            .cornerRadius(8)
            
    }
    
}

struct ButtonView: View {

    var body: some View {
        ZStack {
            Button {} label: {
                Text("Add Food")
                    .font(.system(size: 32))
                    .foregroundColor(.white)
            }
            .buttonStyle(AddButtonStyle())
            
        }
    }
}

#Preview {
    ButtonView()
}
