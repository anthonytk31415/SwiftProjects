//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Anthony TK on 8/26/23.
//

import Foundation


// build an Identifiable protocol type so it's unique: it requires a UUID
struct ExpenseItem: Identifiable, Codable {
    var id = UUID()     // let swift make the UUID and they're unique all the time using the function
    let name: String
    let type: String
    let amount: Double
    
}

