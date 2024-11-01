//
//  Make_it_GreatApp.swift
//  Make-it-Great
//
//  Created by João Pedro Albuquerque on 30/09/24.
//

import SwiftUI
import SwiftData

@main
struct Make_it_GreatApp: App {

    @AppStorage("firstUse") var firstUse: Bool = true // logica para checar se eh a primeira sessao do usuario
    
    var body: some Scene {
        WindowGroup {
            if firstUse {
                OnboardingView() //substituir para a tela de onboarding
            } else {
                MainScreenView()
            }
        }
        .modelContainer(for: [Food.self])
    }
}
