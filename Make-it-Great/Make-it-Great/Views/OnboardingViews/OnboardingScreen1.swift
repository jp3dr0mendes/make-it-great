//
//  OnboardingScreen1.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 23/10/24.
//

import SwiftUI

struct OnboardingScreen1: View {
    var body: some View {
        
        VStack {
            
            Text("Organize")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.purpleItens)
            
            Text("Controle")
                .font(.largeTitle)
                .bold()
                .padding()
                .foregroundColor(.purpleItens)
            
            Text("Aproveite")
                .font(.largeTitle)
                .bold()
                .padding()
                .foregroundColor(.purpleItens)
            
            Text("Seus alimentos com:")
                .font(.title2)
                .multilineTextAlignment(.center)
                .bold()
                .padding()
                .foregroundColor(.purpleItens)
            
            Text("FreshConserve")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.black)
            
//            Text("Explore nosso aplicativo e descubra suas funcionalidades.")
//                .multilineTextAlignment(.center)
//                .padding()
            Image("AppIconOnboarding") // Imagem para a tela 1
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    OnboardingScreen1()
}
