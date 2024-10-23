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
    @Binding var storageType: StorageType
    
    @State var navegar = false
    
    var body: some View {
       
        HStack {
            Spacer()
            Menu {
                Button {
                    navegar = true
                } label: {
                    Text("Scannear")
                    Image(systemName: "camera.viewfinder")
                }
                
                Button("Adicionar Manualmente", systemImage: "pencil") {
                    isPresentedSheet = true
                }
            } label: {
                Image(systemName: "plus.circle")
                    .font(.system(size: 25))
                    .foregroundStyle(.purpleItens)
//                Label("", systemImage: "plus.circle.fill")
//                    .font(.system(size: 25)) // Ajuste o tamanho do ícone aqui
            }
            //.padding(.trailing, 16)
//                .border(.black)
        }
        .navigationDestination(isPresented: $navegar) {
            ScreenScan(isPresentedMenu: $isPresentedMenu, storageType: $storageType, navegarAnterior: $navegar)
        }
        
    }
}

//#Preview {
//    @Previewable @State var isPresentedMenu: Bool = false
//    @Previewable @State var isPresentedSheet: Bool = false
//    AddMenu(isPresentedMenu: $isPresentedMenu, isPresentedSheet: $isPresentedSheet)
//}
