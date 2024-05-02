//
//  ContentView.swift
//  My Favorite Recipes
//
//  Created by Anthony TK on 8/15/23.
//

import SwiftUI




struct ContentView: View {
    let recipeNames = ["Italian Pizza Chicken",
                       "Greek Pasta Bake",
                       "Hearty Parsnip Soup"]
    
    @ObservedObject var recipeModel = RecipeModel()
    
    var recipes = [RecipeModel]()
    var body: some View {
        Group {
            VStack{
                List(recipeNames, id: \.self) { name in
                    Text("\(name)")
                }
                List(recipeModel.recipes, id: \.self) { name in
                    Text("\(name)")
                }
            }
        }
    }
}




//        VStack(alignment: .leading) {
//            List(recipes, id: \.id) { recipe in
//                VStack {
//                    Text("\(recipe.name)")
//                        .font(.headline)
//                    Text("\(recipe.origin)")
//                        .font(.subheadline)
//                }
//
//            }
//        }
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
