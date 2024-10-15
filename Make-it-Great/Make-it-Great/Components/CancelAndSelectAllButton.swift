//
//  CancelAndSelectAllButton.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 15/10/24.
//

import SwiftUI

struct CancelAndSelectAllButton: View {
    var body: some View {
        
        //Cancel Button:
        HStack {
            
            Button(action: {
                
                //Navegar para alguma tela
                
            }) {
                Text("Cancel")
                    .padding()
                //.background(Color.white)
                    .font(.system(size: 15))
                    .foregroundColor(.purpleItens)
                
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.purpleItens, lineWidth: 1)
                    .frame(width: 68, height: 36)
            )
            Spacer()
            //Select All button
            Button(action: {
                
                //Navegar para alguma tela
                
            }) {
                Text("Select All")
                    .padding()
                //.background(Color.white)
                    .font(.system(size: 15))
                    .foregroundColor(.purpleItens)
                
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.purpleItens, lineWidth: 1)
                    .frame(width: 83, height: 36)
            )
            
        }
    }
}

#Preview {
    CancelAndSelectAllButton()
}
