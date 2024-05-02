//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Anthony TK on 9/8/23.
//

import SwiftUI

struct ContentView: View {
//    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(sortDescriptors: []) var wizards: FetchedResults<Wizard>
//    @FetchRequest(sortDescriptors: [], predicate: nil ) var ships: FetchedResults<Ship>
    
    var body: some View {
        NavigationView {
            List{
                NavigationLink("Wizards List", destination: WizardsView())
                NavigationLink("Ships List", destination: ShipsView())
                NavigationLink("1989 Songs List", destination: Songs())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
