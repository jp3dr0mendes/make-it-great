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
                    if currentPage > 0 {
                        Button(action: {
                            if currentPage > 0 {
                                currentPage -= 1
                            }
                        }) {
                            Image(systemName: "chevron.left")
                            Text("Voltar")
                            Spacer()
                        }
                        .foregroundStyle(.purpleItens)
                    }
                    PageView(currentPage: $currentPage)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.white)
                    
                    VStack {
                        Button(action: {
                            if currentPage < 3 { // Supondo que temos 3 telas
                                currentPage += 1
                            } else {
                                isOnboardingActive = false
                            }
                        }, label: {
                            Text(currentPage < 3 ? "Próximo" : "Finalizar")
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(.purpleItens)
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .fontWeight(.semibold)
                        })
                        .padding(.bottom)
                        Button(action: {
                            isOnboardingActive = false
                        }) {
                            Text("Pular")
                                .foregroundStyle(.black)
                                .fontWeight(.semibold)
                        }
                    }
                }
                .padding()
            } else {
                MainScreenView()
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
            OnboardingScreen3()
        case 3:
            OnboardingScreen4()
        default:
            MainScreenView()
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
