//
//  ContentView.swift
//  BetterRest
//
//  Created by Anthony TK on 8/23/23.
//
import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount: Int = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert: Bool = false
    
    private var calcMsg: String {
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            // hour and minutes in seconds
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            // now feed this into model to get output i.e. get the prediction
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            // subtract sleep from wakeup time
            let sleepTime = wakeUp - prediction.actualSleep
            let msg = sleepTime.formatted(date: .omitted, time: .shortened)
            
            return "We reccomend sleeping at \(msg)"
        } catch {
            return "Error with calculating the sleep time."
        }
    }
    
    // make this static because if it's not, then which property do you read first?

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    let cupsRange: [Int] = Array(1...20)
    
    var body: some View {
        NavigationView {
            Form {
                VStack (alignment: .leading, spacing: 0){
                    Text("When do you want to wake up?")
                       .font(.headline)
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }

                VStack (alignment: .leading, spacing: 0){
                    Text("Desired amount of sleep")
                        .font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                VStack (alignment: .leading, spacing: 0){
                    Text("Daily coffee intake")
                        .font(.headline)
//                    Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20, step: 1)
                    Picker("Select Output Unit", selection: $coffeeAmount) {
                        ForEach(cupsRange, id: \.self){
                            Text("\($0)")
                        }
                    }
                }
                Text(calcMsg)
            }
            .navigationTitle("Better Rest")
            .toolbar {
                Button("Calculate", action: calculatedBedtime)
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func calculatedBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            // hour and minutes in seconds
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            // now feed this into model to get output i.e. get the prediction
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            // subtract sleep from wakeup time
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is:"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        
        } catch {
            alertTitle = "Error"
            alertMessage = "There was a problem calculating your bedtime."
        }
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
