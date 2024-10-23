//
//  SegmentedControlComponent.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 02/10/24.
//

import SwiftUI

struct SegmentedControlComponent: View {
    @Binding var selectedCategory: FoodType
    /*@State private var selectedCategory: TaskCategory = .refrigerator*/ // Define a categoria inicial

    var body: some View {
        VStack {
            //            Text("Select a Category:")
            //                .font(.headline)
            HStack(spacing: 20) {
                //Picker(selection: $selectedCategory, label: Text("Category")) {
                ForEach(FoodType.allCases) { category in
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
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.4)) {
                                selectedCategory = category
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20)
                            .stroke(selectedCategory == category ? selectedCategory.color: .white)
                            .animation(.snappy, value: selectedCategory)
                            .frame(width: 115)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .trim(from: 0, to: selectedCategory == category ? 1 : 0)
                                    .stroke(selectedCategory.color, lineWidth: 1.5)
                                    .rotationEffect(.degrees(180))
                                    .animation(.easeInOut(duration: 0.4), value: selectedCategory)
                                    .frame(width: 115)
                                )
                        )
                    }
                }
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
//    SegmentedControlComponent(selectedCategory: .Fruta)
//}
