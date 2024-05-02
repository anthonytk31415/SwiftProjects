//
//  ContentView.swift
//  iExpense
//
//  Created by Anthony TK on 8/26/23.
//
import SwiftUI

struct ExpenseCategory: View {
    let type: String
    @ObservedObject var expenses: Expenses
    let currency: String
    let removeItems: (IndexSet) -> Void
    let chooseColor: (Double) -> Color

    var body: some View {
        Section(header: Text("\(type) Expenses")){
            ForEach(expenses.items) { item in
                if item.type == type{
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        
                        Text(item.amount, format: .currency(code: currency))
                            .foregroundColor(chooseColor(item.amount))
                    }
                    
                }
            }
            .onDelete(perform: removeItems)
        }
    }
}


struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    let currency: String = Locale.current.currency?.identifier ?? "USD"
    
    var body: some View {
        NavigationView{
            List(){
                // recall: the \.name requires unique id's so you get an error message; we'll explore
                // better solutions next
                // NOTE: with "identifiable", can leave id: blah out b/c its identifiable!
                // This format of the Title, subtitle on the left, then detail on the right is common!\
                
// before we created the ExpenseCategory struct
//                Section(header: Text("Personal Expenses")){
//                    ForEach(expenses.items) { item in
//                        if item.type == "Personal"{
//                            HStack {
//                                VStack(alignment: .leading) {
//                                    Text(item.name)
//                                        .font(.headline)
//                                    Text(item.type)
//                                }
//
//                                Spacer()
//
//                                Text(item.amount, format: .currency(code: currency))
//                                    .foregroundColor(chooseColor(item.amount))
//                            }
//
//                        }
//                    }
//                    .onDelete(perform: removeItems)
//                }
//
//                Section(header: Text("Business Expenses")){
//                    ForEach(expenses.items) { item in
//                        if item.type == "Business"{
//                            HStack {
//                                VStack(alignment: .leading) {
//                                    Text(item.name)
//                                        .font(.headline)
//                                    Text(item.type)
//                                }
//
//                                Spacer()
//
//                                Text(item.amount, format: .currency(code: currency))
//                                    .foregroundColor(chooseColor(item.amount))
//                            }
//
//                        }
//                    }
//                    .onDelete(perform: removeItems)
//                }
                ExpenseCategory(type: "Personal", expenses: expenses, currency: currency, removeItems: removeItems, chooseColor: chooseColor)
                ExpenseCategory(type: "Business", expenses: expenses, currency: currency, removeItems: removeItems, chooseColor: chooseColor)
                
            }
            .navigationTitle("iExpense")
            .toolbar{
                Button{
                    showingAddExpense = true

                } label: {
                    Image(systemName: "plus")
                }
                EditButton()
            }
            .sheet(isPresented: $showingAddExpense){            //the sheet is toggled with a View and
                AddView(expenses: expenses, currency: currency)                     // an arg
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    func chooseColor(_ amount: Double) -> Color {
        if amount <= 10.0 {
            return .black
        } else if amount <= 50 {
            return .blue
        } else {
            return .red
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
