//
//  Expenses.swift
//  iExpense
//
//  Created by Anthony TK on 8/26/23.
//

import Foundation


// use codable protocol
// add user defaults to laod
// use custom initializer to load data
//

class Expenses: ObservableObject {              // define "ObservableObject" protocol
    @Published var items = [ExpenseItem](){      // @Published will allow changes to the class
        didSet{
//            let encoder = JSONEncoder()
            
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "PersonalItems")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "PersonalItems"){
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){ // the .self refers to that "type"
                items = decodedItems
                return
            }
        }
        items = []
    }
}

