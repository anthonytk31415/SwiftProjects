//
//  ContentView.swift
//  TempChanger
//
//  Created by Anthony TK on 8/22/23.
//

import SwiftUI

struct ContentView: View {
    
    let tempType = ["K", "C", "F"]
    @State private var inputUnit: String = "F"
    @State private var outputUnit: String = "C"
    @State private var tempInput: Double = 85.0
    @FocusState private var amountIsFocused: Bool
    private var tempOutput: Double {
        return findTemp(amt: tempInput, input: inputUnit, output: outputUnit)!
    }
    
    
    var body: some View {
        NavigationView {
            Form{
                Section{
                    TextField("Input Temperature:", value: $tempInput, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                } header: {
                    Text("Enter Input Temperature")
                }
                
                Section {
                    Picker("Select Input Unit", selection: $inputUnit) {
                        ForEach(tempType, id: \.self){
                            Text($0)
                        }
                    }
                    Picker("Select Output Unit", selection: $outputUnit) {
                        ForEach(tempType, id: \.self){
                            Text($0)
                        }
                    }
                } header: {
                    Text("Enter Input and Output Units")
                }
                
                Section{
                    Text(tempOutput, format: .number)
                } header: {
                    Text("Output Temperature")
                }
            }
            .navigationTitle(Text("Temperature Conversion"))
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
