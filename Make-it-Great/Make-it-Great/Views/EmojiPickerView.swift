//
//  EmojiPickerView.swift
//  Make-it-Great
//
//  Created by Yane dos Santos on 16/10/24.
//

import UIKit
import SwiftUI

struct EmojiPickerView: UIViewControllerRepresentable {
    
    @Binding var selected: String
    
    func makeUIViewController(context: Context) -> UIViewController {
        UINavigationController(rootViewController: GridCollectionControllerView(selected: $selected))
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        //
    }
    
    
}

//#Preview {
//    @Previewable @State var isShowingEmojiPicker = false
//    @Previewable @State var selectedEmoji = ""
//    Button("Show Emoji Picker = \(selectedEmoji)") {
//        isShowingEmojiPicker = true
//    }
//    .sheet(isPresented: $isShowingEmojiPicker) {
//        EmojiPickerView(selected: $selectedEmoji)
//    }
//}
