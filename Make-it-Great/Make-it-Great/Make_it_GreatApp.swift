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
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
    @AppStorage("firstUse") var firstUse: Bool = false // logica para checar se eh a primeira sessao do usuario
    var body: some Scene {
        WindowGroup {
            if firstUse {
                AddItem(isPresented: true) //substituir para a tela de onboarding
            } else {
                AddItem(isPresented: true)
            }
        }
//        .modelContainer(for: [Food.self])
    }
}
