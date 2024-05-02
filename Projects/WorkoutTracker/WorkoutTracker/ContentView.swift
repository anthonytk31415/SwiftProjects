//
//  ContentView.swift
//  WorkoutTracker
//
//  Created by Anthony TK on 8/29/23.
//

import SwiftUI

// build stuff so your child structs can share info and display the

struct SampleText: View {
    var body: some View {
        Text("Hi there")
    }
}

struct ContentView: View {
    let workouts: [Workout] = Bundle.main.decode("workouts.json")
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    ForEach(workouts, id: \.id) { workout in
                        NavigationLink("Workout: \(workout.name)", destination: SampleText())
                    }
                } header: {
                    Text("Workout List")
                }
                Section {
                    Text("hi there")
                    TaylorInfo()
                } header: {
                    Text("Auxiliary Information")
                }
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
