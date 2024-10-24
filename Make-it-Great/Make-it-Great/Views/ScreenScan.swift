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
    @Binding var foodType: FoodType
    @Binding var navegarAnterior: Bool
    @State var navegar: Bool = false
    
    @State var foods: [Food] = []
    
    @State var classification: String = ""
    
    var body: some View {
        
        //        NavigationView {
        
        VStack(spacing: 20) {
            Text("Passe os alimentos pela câmera")
                .bold()
                .foregroundStyle(.white)
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
            //                Text(classification)
            
            
            //Aqui Chama a camera que foi convertida para SwiftUI
            CameraView(classification: $classification, foods: $foods,food: $foodType)
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
            
            
            Button {
                navegar = true
            } label: {
                Text("Confirmar itens")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .background(foodType == .Fruta ? .brownFruits : .greenVegetables)
                    .cornerRadius(10)
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
        }
        .background(Color.black.opacity(0.9))
        .navigationTitle("")
        .navigationDestination(isPresented: $navegar) {
            IdentifiedFoodScreen(detectedFoods: $foods, food: $foodType, isPresented: $isPresentedMenu, navegarAnterior: $navegar)
        }
        .onChange(of: navegar) { oldValue, newValue in
            if newValue == false {
                navegarAnterior = false
            }
        }
    }
    // }
}
