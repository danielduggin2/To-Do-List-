//
//  ListRowView.swift
//  ToDoList
//
//  Created by Daniel Wade Duggin on 2/6/23.
//

import SwiftUI

struct ListRowView: View {
    let item: itemModel
    var body: some View {
        HStack{
            Image(systemName: item.isComplete ? "checkmark.circle": "circle")
                .foregroundColor(item.isComplete ? .green : .red)
            Text(item.title)
                //.foregroundColor(Color("TextColor"))
            Spacer()
        }
        //.background(Color("Background"))
        .font(.title2)
        .padding(.vertical,8)
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var item1 = itemModel(title: "First", isComplete: false)
    static var item2 = itemModel(title: "Second", isComplete: true)
    
    static var previews: some View {
        Group{
            ListRowView(item: item1)
            ListRowView(item: item2)
        }
        .previewLayout(.sizeThatFits)
    }
}
