//
//  OnboardingScreen.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 23/10/24.
//

import SwiftUI

import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @State private var isOnboardingActive = true

    var body: some View {
        ZStack {
            if isOnboardingActive {

                VStack {
                    Spacer()
                    PageView(currentPage: $currentPage)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.white)
                        .edgesIgnoringSafeArea(.all)

                    HStack {
                        
                        Button(action: {
                            if currentPage > 0 {
                                currentPage -= 1
                            }
                        }) {
                            Text("Anterior")
                        }
                        .padding()
                        .opacity(currentPage == 0 ? 0 : 1) // Oculta o botão se estiver na primeira tela

                        Spacer()

                        Button(action: {
                            if currentPage < 2 { // Supondo que temos 3 telas
                                currentPage += 1
                            } else {
                                isOnboardingActive = false
                            }
                        }) {
                            Text(currentPage < 2 ? "Próximo" : "Finalizar")
                        }
                        .padding()

                        Spacer()

                        Button(action: {
                            isOnboardingActive = false
                        }) {
                            Text("Pular")
                                .foregroundColor(.red)
                        }
                        .padding()
                    }
                    .padding()
                }
            } else {
                // Aqui você pode adicionar a tela principal do seu aplicativo
                Text("Tela Principal")
                    .font(.largeTitle)
                    .padding()
            }
        }
    }
}

struct PageView: View {
    @Binding var currentPage: Int

    var body: some View {
        switch currentPage {
        case 0:
            VStack {
                OnboardingScreen1()
                    
            }
        case 1:
            VStack {
                OnboardingScreen2()
            }
        case 2:
            VStack {
                Image("explore_image") // Imagem para a tela 3
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                Text("Tela 3: Fique à vontade para explorar!")
                    .font(.largeTitle)
                    .padding()
                Text("Aproveite sua jornada conosco.")
                    .multilineTextAlignment(.center)
                    .padding()
            }
        default:
            Text("Tela final.")
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
