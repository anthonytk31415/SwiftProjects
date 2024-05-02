//
//  Ships.swift
//  CoreDataProject
//
//  Created by Anthony TK on 9/9/23.
//

// add delete features
// Filter Logic:
// - we first call on moc's ships array to find the set of all universes
// - default universe = ""; if so, then no filters applied
// - otherwise, we filter using the view that calls the filter



import SwiftUI

struct ShipsView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var ships: FetchedResults<Ship>
    
    @State private var universe = ""
    
    var universes: [String] {
        var setOfShips = Set<String>()
        for ship in ships {
            if let curUniverse = ship.universe {
                setOfShips.insert(curUniverse)
            }
        }
        var res = Array(setOfShips)
        res.sort()
        return res
    }
    
    var body: some View {
        Group {
            Section {
                List {
                    Picker("Choose filter:", selection: $universe) {
                        Text("").tag("")
                        ForEach(universes, id: \.self) {
                            Text($0)
                        }
                    }
                }
            }
            
            Section {
                ShipsContentView(universe: universe)
            }
                
            Section {
                Button ("Add Examples", action: addExample)
            }
            
        }
    }
    
    func addExample() {
        let shipNames = ["Enterprise", "Defiant", "Millenium Falcon", "Executor"]
        let shipUniverses = ["Star Trek", "Star Trek", "Star Wars", "Star Wars"]
        
        for i in 0..<4 {
            let curShip = Ship(context: moc)
            curShip.name = shipNames[i]
            curShip.universe = shipUniverses[i]
        }
        
        try? moc.save()
    }
}

struct ShipsView_Previews: PreviewProvider {
    static var previews: some View {
        ShipsView()
    }
}
