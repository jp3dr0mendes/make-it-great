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
            HStack(spacing: 20) {
                //Picker(selection: $selectedCategory, label: Text("Category")) {
                ForEach(StorageType.allCases) { category in
                    VStack(spacing: 4) {
                        Image(category.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 83)
                        Text(category.description)
                            .foregroundStyle(category.color)
                        // .tag(category)
                    }
                    .onTapGesture {
                        selectedCategory = category
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20)
                        .stroke(selectedCategory == category ? selectedCategory.color: .white, lineWidth: 1.5)
                        .frame(width: 115)
                    )
                }
                
            }
            //.pickerStyle(SegmentedPickerStyle()) // Aplica o estilo segmentado
            
            
            Text("Place: \(selectedCategory.description)")
                .padding()
            //}
                //.padding()
        }
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
