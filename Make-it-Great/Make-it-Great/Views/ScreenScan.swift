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
    @State var food: Food?
    
    @State var classification: String = ""
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                Text("Screen Scan")
                Text(classification)
                
//                if  CameraView().classification != ""{
//                    if CameraView().classification == ""{
//                        self.food = nil
//                    }
//                }
                //Aqui Chama a camera que foi convertida para SwiftUI
                CameraView(classification: $classification)
                    .edgesIgnoringSafeArea(.all)
                    .border(.blue)
                
                NavigationLink(destination: IdentifiedFoodScreen()) {
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
