//
//  AddMenu.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 16/10/24.
//

import SwiftUI

struct AddMenu: View {
    
//    @State var isPresentedSheet: Bool = false
//    @State var isPresentedMenu: Bool = false
    @Binding var isPresentedMenu: Bool
    @Binding var isPresentedSheet: Bool
    
    var body: some View {
       
        HStack {
            Spacer()
            Menu {
                NavigationLink(destination: ScreenScan(isPresentedMenu: $isPresentedMenu)) {
                    Text("Scannear")
                    Image(systemName: "camera.viewfinder")
                }
                
                Button("Adicionar Manualmente", systemImage: "pencil") {
                    isPresentedSheet = true
                }
            } label: {
                Label("", systemImage: "plus.circle.fill")
                    .font(.system(size: 25)) // Ajuste o tamanho do ícone aqui
            }
            .padding(.trailing, 16)
                //.border(.black)
        }
        
    }
}

#Preview {
    @Previewable @State var isPresentedMenu: Bool = false
    @Previewable @State var isPresentedSheet: Bool = false
    AddMenu(isPresentedMenu: $isPresentedMenu, isPresentedSheet: $isPresentedSheet)
}
