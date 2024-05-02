//
//  User.swift
//  CupcakeCorner
//
//  Created by Anthony TK on 8/30/23.
//

import Foundation




// goal: make the user class Codable despite the Published
// use:
class User: ObservableObject, Codable {
    // archive and unarchive; convention = "CodingKeys"
    // properties that need to code go in here
    
    enum CodingKeys: CodingKey {
        case name
    }
        
    @Published var name = "Taylor Swift"    // announces change; Published uses a generic
    
    // for decode to work:
    // - must have required so that inherited classes get this init
    // - decoder: up to us to say how to read it
    // - required: we will require this (using child super(init)) so that the children that
    //   inherits User will also be codable (in this case)
    // - (*) goes through the container keys and for the one that == name, it will decode it
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)             // (*)
    }
    
    // for encode to work:
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}
