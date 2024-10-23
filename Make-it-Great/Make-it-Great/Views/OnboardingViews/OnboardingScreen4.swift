//
//  OnboardingScreen4.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 23/10/24.
//

import SwiftUI

struct OnboardingScreen4: View {
    var body: some View {
        VStack{
            Text("Vamos ajudar você a aproveitar o máximo de seus alimentos!")
                .font(.largeTitle)
                .foregroundStyle(.purpleItens)
                .bold()
                .multilineTextAlignment(.center)
            Image("AppleCarrotRun")
                .resizable()
                .scaledToFit()
                .padding()
            
        }
    }
}

#Preview {
    OnboardingScreen4()
}
