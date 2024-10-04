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
    
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                Text("Screen Scan")
                
                //Aqui Chama a camera que foi convertida para SwiftUI
                CameraView()
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
