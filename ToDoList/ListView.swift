//
//  ListView.swift
//  ToDoList
//
//  Created by Daniel Wade Duggin on 2/6/23.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        ZStack{
            if listViewModel.items.isEmpty{
               NoItemsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            }else{
                List{
                    ForEach(listViewModel.items){ item in
                        ListRowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear){
                                    listViewModel.updateItem(item: item)
                                }
                            }
                        //this changes the color of the white space behind the list items
                            .listRowBackground(Color("NewBackground"))
                    }
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
                    .foregroundColor(Color("TextColor"))
                    .padding()
                    //makes the list items purple
                    .background(Color.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .listStyle(.plain)
                            
            }
            
        }
        .background(Color("NewBackground"))
        .navigationTitle("Today's Tasks").foregroundColor(Color.red)
        .navigationBarItems(
           leading: EditButton().foregroundColor(Color.accentColor),
           trailing:
                NavigationLink("Add", destination: AddView()).foregroundColor(Color.accentColor)
        )
        
        
    }
    
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ListView()
        }
        .environmentObject(ListViewModel())
    }
}

struct listDone{
    
}


/*
 .toolbar{
     ToolbarItem(placement: .principal){
         Text("To Do")
     }
 }
 .navigationBarTitleDisplayMode(.inline)
                 .toolbarBackground(.red, for: .navigationBar)
                 .toolbarBackground(.visible, for: .navigationBar)
 */
