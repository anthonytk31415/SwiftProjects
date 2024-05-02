//
//  CoreDataEx.swift
//  Bookworm
//
//  Created by Anthony TK on 9/1/23.
//

import SwiftUI

// coredata needs to know what data you're using and how it links to others
// figure out data properties at runtime
// - set up the xcdatamodel
// - define the data's entity
// - 
// -

//struct Student {
//    var id: UUID
//    var name: String
//}



struct CoreDataEx: View {
    var body: some View {
        VStack {
            Text("Core Data Examples")
        }
     }
}

struct CoreDataEx_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataEx()
    }
}
