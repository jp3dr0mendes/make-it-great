//
//  TrashItemButton.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 22/10/24.
//

import SwiftUI

struct TrashItemButton: View {
    var body: some View {
        
        HStack {
            Spacer()
            Button {
                //Deleta alguma coisa
            } label: {
                Image(systemName: "trash")
            
            }
        }.padding()
    }
}

#Preview {
    TrashItemButton()
}
