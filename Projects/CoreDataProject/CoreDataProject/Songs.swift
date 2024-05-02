//
//  SampleList.swift
//  CoreDataProject
//
//  Created by Anthony TK on 9/9/23.
//

import SwiftUI

struct Songs: View {
    @State private var selection: String?
    
    var names = [
        "Cyril",
        "Lana",
        "Mallory",
        "Sterling"
    ]
    
    var body: some View {
        Group {
            List(names, id: \.self, selection: $selection) { name in
                Text(name)
            }
//            .onMove { names.move(fromOffsets: $0, toOffset: $1) }
            .navigationTitle("List Selection")
            .toolbar {
                EditButton()
            }
        }
    }
}

struct Songs_Previews: PreviewProvider {
    static var previews: some View {
        Songs()
    }
}
