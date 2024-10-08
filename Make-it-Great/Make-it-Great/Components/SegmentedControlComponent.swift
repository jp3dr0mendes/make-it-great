//
//  SegmentedControlComponent.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 02/10/24.
//

import SwiftUI

struct SegmentedControlComponent: View {
    @Binding var selectedCategory: StorageType
    /*@State private var selectedCategory: TaskCategory = .refrigerator*/ // Define a categoria inicial

    var body: some View {
        VStack {
//            Text("Select a Category:")
//                .font(.headline)
            
            Picker("Category", selection: $selectedCategory) {
                ForEach(StorageType.allCases) { category in
                    Text(category.description)
                        .tag(category)
                }
            }
            .pickerStyle(SegmentedPickerStyle()) // Aplica o estilo segmentado

            Text("Place: \(selectedCategory.description)")
                .padding()
        }
        .padding()
    }
}

//struct TaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskView(selectedCategory: Binding<TaskCategory>)
//    }
//}
//#Preview {
//    
//    TaskView(selectedCategory: TaskCategory.refrigerator)
//}
