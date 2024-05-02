//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Anthony TK on 8/22/23.
//

import SwiftUI

// uses generics: use any content that follows View protocol
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content      // fn input!
    // you can or cannot use viewbuilder if you leave those
    // enclosing buckets out
    
    
    var body: some View {
        VStack{
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) {column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        GridStack(rows: 4, columns: 4) { row, col in
            Image(systemName: "\(row * 4 + col).circle")
            Text("R\(row) C\(col)")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
