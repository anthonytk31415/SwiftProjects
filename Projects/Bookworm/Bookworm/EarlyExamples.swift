//
//  EarlyExamples.swift
//  Bookworm
//
//  Created by Anthony TK on 9/1/23.
//

import SwiftUI

struct EarlyExamples: View {
    @State private var rememberMe = false
    let desc = "The block above demonstrates usage of @Binding in Child Views"
    
    var body: some View {
        VStack {
            Section{
                Toggle("Click to activate the Binding Example", isOn: $rememberMe)
            }
            Section {
                PushButton(title: "Remember Me", isOn: $rememberMe)
            }
            Section {
                Text(rememberMe ? "On" : "Off")
                    
            }
            Section {
                Text(desc)
                    .background(.gray)
                    .foregroundColor(.white)
            }
            TextEditorEx()
                .foregroundColor(.black)
                .background(.black)
        }
    }
}

struct EarlyExamples_Previews: PreviewProvider {
    static var previews: some View {
        EarlyExamples()
    }
}
