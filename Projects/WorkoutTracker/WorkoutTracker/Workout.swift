//
//  Workouts.swift
//  WorkoutTracker
//
//  Created by Anthony TK on 8/29/23.
//

import Foundation
import SwiftUI

// if you use nested structs, ensure that the nested struct itself is Codable and Identifiable
// use var id = UUID() to ensure Identifiable

// we ensure the code is Codable by using the enum and properties that are Codable. 

//struct Workout: Codable, Identifiable {
struct Workout: Codable, Identifiable {
    struct Movement: Codable, Identifiable{
        //
        var id = UUID()
        let name: String
        let quantity: Int
        let quantityUnit: String
        let dim: Int?
        let dimUnit: String?
        let notes: String?
    
        // specify all your columns you need to encode
        enum CodingKeys: CodingKey {
            case name
            case quantity
            case quantityUnit
            case dim
            case dimUnit
            case notes

        }
    }
    
    var id = UUID()
    let name: String
    let sport: String
    let workoutType: String
    let numRounds: Int
    let workout: [Movement]
    
    enum CodingKeys: CodingKey{
        case name
        case sport
        case workoutType
        case numRounds
        case workout

    }
}
