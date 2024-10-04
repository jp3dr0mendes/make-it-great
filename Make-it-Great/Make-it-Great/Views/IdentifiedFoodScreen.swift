//
//  IdentifiedFoodScreen.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 04/10/24.
//

import SwiftUI

struct IdentifiedFoodScreen: View {
    var body: some View {
        VStack {
            Text("Identified Food")
            
            List {
                ForEach(0..<10) { index in
                
                    HStack {
                        
                        Image(systemName: "leaf.fill")
//                            .resizable()
//                            .frame(width: 40, height: 40)
//                            .foregroundColor(.green)
                        Text("Food \(index)")
                            .font(.headline)
                    }
                    
                }
            }
            
        }
    }
}

#Preview {
    IdentifiedFoodScreen()
}
