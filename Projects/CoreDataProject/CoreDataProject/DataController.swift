//
//  DataController.swift
//  CoreDataProject
//
//  Created by Anthony TK on 9/8/23.
//

import CoreData
import Foundation

// Steps:
// 1) use state object with it
// this contains the entities and relationships; but we have to load the data
// 2) will need to build a "load data" step
// 3) the inject into environment via the __app. swift fle
// 4) initiate student dataset from coredata

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CoreDataProject")
    
    // load data
    
    init() {
        // 1) load data step
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
                return 
            }
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
        
    }
    
}
