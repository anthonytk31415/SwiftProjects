//
//  SampleJSON.swift
//  WorkoutTracker
//
//  Created by Anthony TK on 8/30/23.
//

import Foundation
import SwiftUI

struct TaylorInfo: View {
    let input = """
        {
            "name": "Taylor Swift",
            "address": {
                "street": "555, Taylor Swift Avenue",
                "city": "Nashville"
            }
        }
        """
    
    struct User: Codable {
        let name: String
        let address: Address
    }
    
    struct Address: Codable {
        let street: String
        let city: String
    }
    
    func buttonFn(){
        let data = Data(input.utf8)         // this puts things to UTF 8; 
        let decoder = JSONDecoder()
        if let user = try? decoder.decode(User.self, from: data) {
            print(user.address.street)
        }
    }

    var body: some View {
        Button("taylor address", action: buttonFn)
    }
}
