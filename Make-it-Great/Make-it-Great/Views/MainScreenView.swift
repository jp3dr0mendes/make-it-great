//
//  MainScreenView.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 02/10/24.
//

import SwiftUI

struct MainScreenView: View {
    
    @State private var selectedCategory: StorageType = .refrigerator
    @State var isPresented: Bool = false
    
    var body: some View {
        
        VStack {
            
            SegmentedControlComponent(selectedCategory: $selectedCategory)
            
            Button("Adicionar Item"){
                isPresented = true            }
        }
        .sheet(isPresented: $isPresented, content: {
            AddItem(isPresented: $isPresented)
        })
    }
}

#Preview {
    MainScreenView()
}

