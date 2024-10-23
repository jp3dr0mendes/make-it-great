//
//  OnboardingScreen2.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 23/10/24.
//

import SwiftUI

struct OnboardingScreen2: View {
    var body: some View {
        Image("welcome_image") // Imagem para a tela 1
            .resizable()
            .scaledToFit()
            .frame(height: 200)
        Text("Tela 1: Bem-vindo!")
            .font(.largeTitle)
            .padding()
        Text("Explore nosso aplicativo e descubra suas funcionalidades.")
            .multilineTextAlignment(.center)
            .padding()
    }
}

#Preview {
    OnboardingScreen2()
}
