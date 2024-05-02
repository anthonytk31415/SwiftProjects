//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Anthony TK on 8/30/23.
//

import SwiftUI




struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack{
                List{
                    NavigationLink("Songs", destination: Songs())
                    NavigationLink("Image-Async", destination: ImageAsync())
                    NavigationLink("Form Signup", destination: SignupForm())
                    NavigationLink("Order Form", destination: OrderView())
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
