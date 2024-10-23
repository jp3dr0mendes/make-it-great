//
//  OnboardingScreen1.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 23/10/24.
//

import SwiftUI

struct OnboardingScreen1: View {
    var body: some View {
        
        VStack(spacing: 20) {
            
            Text("Organize")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.purpleItens)
            
            Text("Controle")
                .font(.largeTitle)
                .bold()
               // .padding()
                .foregroundColor(.purpleItens)
            
            Text("Aproveite")
                .font(.largeTitle)
                .bold()
               // .padding()
                .foregroundColor(.purpleItens)
            
            Text("Seus alimentos com")
                .font(.title2)
                .multilineTextAlignment(.center)
                .bold()
             //   .padding()
                .foregroundColor(.purpleItens)
                .padding(.bottom)
//            Spacer()
//            padding(.bottom)
            Text("FreshConserve")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.black)
//            Spacer()
        
            Image("AppIconOnboarding") // Imagem para a tela 1
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
        }
        .padding()
    }
}

#Preview {
    OnboardingScreen1()
}
