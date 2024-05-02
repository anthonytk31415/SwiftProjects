//
//  Petition.swift
//  CodeController
//
//  Created by Anthony TK on 9/12/23.
//

import Foundation

// define the struct object that will conform to the objects in JSON import

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
    
}
