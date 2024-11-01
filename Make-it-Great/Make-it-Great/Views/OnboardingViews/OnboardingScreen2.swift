//
//  OnboardingScreen2.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 23/10/24.
//

import SwiftUI

struct OnboardingScreen2: View {
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Image("OnboardingAddTutorial")
                    .resizable()
                    .scaledToFit()
                    .frame(height: proxy.size.height * 0.6)
                Image("EmptyFruits")
                    .resizable()
                    .scaledToFill()
                    .frame(height: proxy.size.height * 0.2)
            }
        }
    }
}

#Preview {
    OnboardingScreen2()
}
