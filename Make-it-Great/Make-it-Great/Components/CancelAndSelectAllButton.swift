//
//  CancelAndSelectAllButton.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 15/10/24.
//

import SwiftUI

struct CancelAndSelectAllButton: View {
    
    @Environment(\.modelContext) var context
    
    @State var selectAll: Bool = false
    @Binding var showingButton: Bool
    @Binding var selected: Bool
    @Binding var selectedItems: Set<Food>
    @Binding var comidas: [Food]
    
    var body: some View {
        
        //Cancel Button:
        HStack {
            
            Button(action: {
                selectAll.toggle()
                selectedItems.removeAll()
                
                withAnimation {
                    showingButton.toggle()
                    selected.toggle()
                    
                }
            }) {
                Text("Cancel")
                    .padding(EdgeInsets(top: 8, leading: 14, bottom: 8, trailing: 14))
                //.background(Color.white)
                    .font(.system(size: 15))
                    .foregroundColor(.purpleItens)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.purpleItens, lineWidth: 1))
                
            }
//            .overlay(
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke(Color.purpleItens, lineWidth: 1)
//                    .frame(width: 72, height: 36)
//            )
            Spacer()
            //Select All button
            Button(action: {
                
                selectAll.toggle()
                toggleSelectionAll(comida: comidas)
               
                //Navegar para alguma tela
                
            }) {
                ZStack {
                    Text("Select All")
                        .padding(EdgeInsets(top: 8, leading: 14, bottom: 8, trailing: 14))
                    //.background(Color.white)
                        .font(.system(size: 15))
                        .foregroundColor(.purpleItens)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.purpleItens, lineWidth: 2))
                }
                
            }
//            .overlay(
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke(Color.purpleItens, lineWidth: 1)
//                    .frame(width: 83, height: 36)
//            )
            
        }
       // .padding(.trailing, 16)
       // .padding(.leading, 16)
    }
    
    private func toggleSelectionAll(comida: [Food]) {
        if selectAll == true {
            selectedItems.removeAll()
            for comida in comidas {
                selectedItems.insert(comida)
            }
        } else {
            selectedItems.removeAll()
        }
    }
}

//#Preview {
//    @Previewable @State var showignButton: Bool = false
//    @Previewable @State var selected: Bool = false
//    CancelAndSelectAllButton(showingButton: $showignButton, selected: $selected, comidas: .constant([""]))
//}
