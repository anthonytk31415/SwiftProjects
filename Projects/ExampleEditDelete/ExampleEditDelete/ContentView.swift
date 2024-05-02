//
//  ContentView.swift
//  ExampleEditDelete
//
//  Created by Anthony TK on 9/9/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: String?
    
//    @State private var selection = Set<String>()
    @State private var isEditing = false
    
    let names = [
        "Cyril",
        "Lana",
        "Mallory",
        "Sterling"
    ]

    var body: some View {
        NavigationStack {
            List(selection: $selection) {
                ForEach(names, id: \.self) { name in
                    Text(name)
                }
                .onDelete(perform: customDelete)
            }
            .navigationTitle("List Selection")
            .toolbar {
                EditButton()
                    .onTapGesture {
                        isEditing.toggle() // Toggle edit mode
                    }
            }
        }
    }
    
    func customDelete(_ x:IndexSet) {
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
