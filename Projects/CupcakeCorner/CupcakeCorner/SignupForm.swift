//
//  SignupForm.swift
//  CupcakeCorner
//
//  Created by Anthony TK on 8/30/23.
//

import SwiftUI

// disable buttons in a form until the data in the forms are valid
struct SignupForm: View {
    @State private var username = ""
    @State private var email = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            Section {
                Button("Create Account") {
                    print("Creating account...")
                }
            }
            .disabled(disableForm)
        }
    }
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
}

struct SignupForm_Previews: PreviewProvider {
    static var previews: some View {
        SignupForm()
    }
}
