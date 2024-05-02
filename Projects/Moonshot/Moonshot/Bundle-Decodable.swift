//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Anthony TK on 8/27/23.
//

import Foundation

// notice all of the fatal warnings!
// we extend bundle because 

// leverage Swift Generics (can work with a variety of types)
// T can be basically anything! but it conforms to a protocol (Codable in this case)
// when we define a var that's an output of decode, we have to specify the type of the var

// this extension is useful!
// side note: Codable is both Decodable and Encodable
extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        // call the URL method to find the file
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        // now convert file to a Data
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to locate \(file) from bundle.")
        }
        
        // now JSON Decode using the [String: astronaut] input form
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed decode \(file) from bundle.")
        }
        return loaded
    }
}
