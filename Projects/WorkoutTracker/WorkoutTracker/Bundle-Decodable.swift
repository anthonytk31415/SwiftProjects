//
//  Bundle-Decodable.swift
//  WorkoutTracker
//
//  Created by Anthony TK on 8/29/23.
//

import Foundation


// decode takes a string, finds the url of that file name inside the package bundle,
// and then converts it from JSON to the output type that you specify when you run the
// function decode and when you specify its output explicitly. 

extension Bundle {
    func decode <T: Codable>(_ file: String) -> T {
        guard let url: URL = self.url(forResource: file, withExtension: nil) else {
            print("error1")
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data: Data = try? Data(contentsOf: url) else {
            print("error2")
            fatalError("Failed to locate \(file) from bundle.")
        }
        
        let decoder: JSONDecoder = JSONDecoder()
        
        guard let loaded: T = try? decoder.decode(T.self, from: data) else {
            print(data)
            print("error3")
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
}
