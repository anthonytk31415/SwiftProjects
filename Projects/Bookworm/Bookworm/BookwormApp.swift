//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Anthony TK on 8/31/23.
//

import SwiftUI

@main


// (3) inject into environment
// - add the data controller in a var and then modify ContentView iwth .environment
//   with a managed object object
// - will allow us to load the data into memory, "play" wiht the data, and when we're done, write to the disk

struct BookwormApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}


