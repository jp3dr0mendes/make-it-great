//
//  MainScreenView.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 01/10/24.
//

import SwiftUI

struct MainScreenView: View {
    
    @State private var selectedCategory: TaskCategory = .refrigerator
    
    var body: some View {
        
        VStack {
            
            TaskView(selectedCategory: $selectedCategory)
            
        }
            
    }
}

#Preview {
    MainScreenView()
}
