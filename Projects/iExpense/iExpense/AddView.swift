//
//  AddView.swift
//  iExpense
//
//  Created by Anthony TK on 8/26/23.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses  // this is the same Expenses as the one one ContentView
    
    let currency: String

    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @Environment(\.dismiss) var dismiss     // this is for closing the view
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView{
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: currency))
                    .keyboardType(.decimalPad)

            }
            .navigationTitle("Add New Expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}


// here, we have to add expenses dummy in the AddView
struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses(), currency: "USD")
    }
}
