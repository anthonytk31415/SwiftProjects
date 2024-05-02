//
//  ContentView.swift
//  WeSplit
//
//  Created by Anthony TK on 8/21/23.
//
//  This is the main UI for the program
import SwiftUI


// This is what is drawn into the screen
// only  requirement of view:
// "views are a function of their state"

//@State is a state var for simple properties only in a view
//

// textfields needs a value it will store
//
struct ContentView: View {

    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    private var currency: String {
        return Locale.current.currency?.identifier ?? "USD"
    }
    
    private var zeroTipSelect: Bool {
        return tipPercentage == 0
    }
    
    // note this is a calc field
    var grandTotalAmt: Double {
        return checkAmount*(1 + Double(tipPercentage)/100)
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount*tipSelection/100
        let grandTotal = checkAmount + tipValue
        let totalPerPerson = grandTotal/peopleCount
        return totalPerPerson
    }
    
    let tipPercentages = [10, 15, 20, 25, 0]

    var body: some View {
        NavigationView {
            Form {
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: currency))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0)")
                        }
                    }
                }
                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Tip Percentage")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: currency))
                } header: {
                    Text("Total amount per person (inc. tip)")
                        .foregroundColor(zeroTipSelect ? .red : .blue)
                }
                Section {
                    Text(grandTotalAmt, format: .currency(code: currency))
                } header: {
                    Text("Grand Total (inc. tip)")
                        .foregroundColor(zeroTipSelect ? .red : .blue)
                }
            }
            .navigationTitle(Text("WeSplit"))
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer() // pushes the spacer so that the button is on the right
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }

    }
}


// this is just for debugging
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
