//
//  IdentifiedFoodScreen.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 04/10/24.
//

import SwiftUI

struct IdentifiedFoodScreen: View {
    
    @Binding var detectedFoods: [Food]
    
    var body: some View {
        VStack {
            Text("Identified Food")
            
            List {
               ForEach(detectedFoods, id: \.self) { food in
                   Text(food.nome)
               }
           }
            
            
        }
    }
}

//#Preview {
//    IdentifiedFoodScreen()
//}
