//
//  OnboardingScreen3.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 23/10/24.
//

import SwiftUI

struct OnboardingScreen3: View {
    var body: some View {
            Image("OnboardingScanTutorial")
                .resizable()
                .scaledToFill()
//                .padding(.trailing)
            Text("Passe suas frutas e verduras na frente da câmera para armazená-las")
            .font(.title2)
            .fontWeight(.semibold)
            .multilineTextAlignment(.center)
            .foregroundStyle(.purpleItens)
    }
}

#Preview {
    OnboardingScreen3()
}
