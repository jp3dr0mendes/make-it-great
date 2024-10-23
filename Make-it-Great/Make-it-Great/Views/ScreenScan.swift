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
            
            VStack(spacing: 20) {
                Text("Passe os alimentos pela câmera")
                    .bold()
                    .foregroundStyle(.white)
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
//                Text(classification)
                
        
                //Aqui Chama a camera que foi convertida para SwiftUI
                CameraView(classification: $classification, foods: $foods,storage: $storageType)
                    .edgesIgnoringSafeArea(.all)
                    .border(.blue)
                
                Text("Comida identificada: ")
                    .foregroundStyle(.white)
                    .font(.title3)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                
                Text(foods.last?.nome ?? "")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.white)

                
                NavigationLink(destination: IdentifiedFoodScreen(detectedFoods: $foods, storage: $storageType, isPresented: $isPresentedMenu)) {
                    Text("Confirm Itens")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .background(storageType == .refrigerator ? .brownFruits : .greenVegetables)
                        .cornerRadius(10)
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
               
            }
            .background(Color.black.opacity(0.9))
            .navigationTitle("")
        }
    }
}
