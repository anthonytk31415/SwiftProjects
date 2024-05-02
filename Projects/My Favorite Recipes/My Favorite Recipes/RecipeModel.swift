//
//  RecipeModel.swift
//  My Favorite Recipes
//
//  Created by Anthony TK on 8/15/23.
//

import Foundation
import SwiftUI
import UIKit

import UIKit

//struct RecipeModel: Identifiable, Hashable {
//    var id = UUID()
//    var name = ""
//    var origin = ""
//}


class RecipeModel: Identifiable, ObservableObject {
    @Published var recipes = [String]()
    var id = UUID()
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.recipes.append(contentsOf: ["Pork & Potato Hotpot",
                                                "Thai Green Curry",
                                                "Italian Sausage & Beans"])
        }
    }
}   


//class RecipeModel: Identifiable, ObservableObject {
//    @Published var recipes = [String]()
//    var id = UUID()
//
//    init() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//            self.recipes.append(contentsOf: ["Pork & Potato Hotpot",
//                                              "Thai Green Curry",
//                                              "Italian Sausage & Beans"])
//        }
//    }
//}
