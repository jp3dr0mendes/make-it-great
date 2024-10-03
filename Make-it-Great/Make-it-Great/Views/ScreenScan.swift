//
//  ScreenScan.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 03/10/24.
//

import SwiftUI
import AVFoundation

struct ScreenScan: View {
    var body: some View {
        Text("Screen Scan")
        
        //Aqui Chama a camera que foi convertida para SwiftUI
        CameraView()
            .edgesIgnoringSafeArea(.all)
            .border(.blue)
        
    }
}

#Preview {
    ScreenScan()
}
