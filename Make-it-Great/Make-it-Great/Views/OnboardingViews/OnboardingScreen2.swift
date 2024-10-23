//
//  OnboardingScreen2.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 23/10/24.
//

import SwiftUI

struct OnboardingScreen2: View {
    var body: some View {
        VStack (alignment: .center) {
            Spacer()
            Image("ConfusedApple") // Imagem para a tela 1
                .resizable()
                .scaledToFit()
                //.frame(height: 200)
        }
        
    }
}

#Preview {
    OnboardingScreen2()
}
