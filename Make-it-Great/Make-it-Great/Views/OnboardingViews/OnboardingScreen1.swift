//
//  OnboardingScreen1.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 23/10/24.
//

import SwiftUI

struct OnboardingScreen1: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
//                Spacer()
                VStack(spacing: 20) {
                    Spacer()
                    Text("Organize")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.purpleItens)
                    Text("Controle")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.purpleItens)
                    Text("Aproveite")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.purpleItens)
                    Text("Seus alimentos com:")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.purpleItens)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.5)
                    Spacer()
                    Text("FreshConserve")
                        .font(.system(size: 48))
                        .bold()
                        .foregroundColor(.greenText)
                        .minimumScaleFactor(0.9)
                }
                .scaledToFill()
                .frame(height: geometry.size.height/2.7)
                Image("AppIconOnboarding") // Imagem para a tela 1
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width * 0.7, height: geometry.size.height * 0.7)
                    .padding(.leading)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .padding()
        }
    }
}

#Preview {
    OnboardingScreen1()
}
