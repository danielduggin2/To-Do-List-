//
//  ListViewModel.swift
//  ToDoList
//
//  Created by Daniel Wade Duggin on 2/6/23.
//

import Foundation

/*
 CRUD Functions
 Create
  Get items
 Read
  Reading items
 Update
  Completion
 Delete
 */

class ListViewModel: ObservableObject{
    // the did set will save any move, add, delete of the items array
    @Published var items: [itemModel] = []{
        didSet{
            saveItem()
        }
    }
    let itemsKey: String = "items_list"
    init(){
        getItems()
    }
    
    func getItems(){
//        let newItems = [
//            itemModel(title: "This is the first title", isComplete: false),
//            itemModel(title: "This is the second title", isComplete: true),
//            itemModel(title: "third", isComplete: false)
//        ]
//        items.append(contentsOf: newItems)
        
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([itemModel].self, from: data)
        else {return}
        
        self.items = savedItems
    }
    
    func deleteItem(indexSet: IndexSet){
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int){
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String){
        let newItem = itemModel(title: title, isComplete: false)
        items.append(newItem)
    }
    
    func updateItem(item: itemModel){
//        if let index = items.firstIndex { (existingItem) -> Bool in
//            return existingItem.id == item.id
//        }{
//            //runs this code
//        }
        
        if let index = items.firstIndex(where: { $0.id == item.id}){
            items[index] = item.updateCompletion()
        }
    }
    
    
    //using user defaults here
    func saveItem(){
        if let encodedData = try? JSONEncoder().encode(items){
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}
