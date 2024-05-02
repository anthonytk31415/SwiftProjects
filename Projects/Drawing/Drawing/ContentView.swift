//
//  ContentView.swift
//  Drawing
//
//  Created by Anthony TK on 8/28/23.
//

import SwiftUI


struct ContentView: View {
    
    // different types of ways you can do backgrounds with images and then replicate them
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink("Shapes", destination: Shapes())
                NavigationLink("Borders", destination: Borders())
                NavigationLink("Metal Ex", destination: DrawingGroupExamples())
                NavigationLink("Blurs and Blending", destination: BlursAndBlending())
                NavigationLink("Animatable Data", destination: AnimatableData())
                NavigationLink("Checkerboard", destination: CheckerboardFun())
                NavigationLink("Arrow", destination: Arrows())
            }
            .navigationTitle("Main Page")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
