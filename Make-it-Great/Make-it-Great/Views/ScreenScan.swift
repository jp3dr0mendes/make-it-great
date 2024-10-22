//
//  ScreenScan.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 03/10/24.
//

import SwiftUI
import AVFoundation

struct ScreenScan: View {
    
    @Binding var isPresentedMenu: Bool
    @Binding var storageType: StorageType
    
    @State var foods: [Food] = []
    
    @State var classification: String = ""
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                Text("Pass the food through the camera")
                    .bold()
//                Text(classification)
                
        
                //Aqui Chama a camera que foi convertida para SwiftUI
                CameraView(classification: $classification, foods: $foods,storage: $storageType)
                    .edgesIgnoringSafeArea(.all)
                    .border(.blue)
                
                Text("Identified food:")
                
                Text(foods.last?.nome ?? "")

                
                NavigationLink(destination: IdentifiedFoodScreen(detectedFoods: $foods, storage: $storageType, isPresented: $isPresentedMenu)) {
                    Text("Confirm Itens")
                        .font(.title2)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}
