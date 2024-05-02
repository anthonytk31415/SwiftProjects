//
//  ShipsContentView.swift
//  CoreDataProject
//
//  Created by Anthony TK on 9/9/23.
//


// ShipsContentView produces the filtered view of Ships based on the universe selection

import SwiftUI

struct ShipsContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var fetchRequest: FetchedResults<Ship>
    
    @State private var selection = Set<Ship>()
    @State private var deleteButtonShow = false
    @State private var isEditMode: Bool = false
    
//  @Environment(\.editMode) private var editMode
//  this is where you define which fetch request is called based on your selector
    init(universe: String){
        if universe == "" {
            _fetchRequest = FetchRequest<Ship>(sortDescriptors: [SortDescriptor(\.name)])
        } else {
            _fetchRequest = FetchRequest<Ship>(sortDescriptors: [SortDescriptor(\.name)],
                                               predicate: NSPredicate(format: "universe == %@", universe))
        }
    }
    
    @Environment(\.editMode) var editMode
    
    var check: Bool {
        withAnimation{
            editMode?.wrappedValue == .active ? true : false
        }
    }
    
    var body: some View {
        Section {
            List(fetchRequest, id: \.self, selection: $selection){ ship in
                Text(ship.name ?? "Unknown name")
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            
            if check {
                Button("Delete Selected", action: selectionDelete)
                    .frame(width: 200, height: 50)
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
            }
        }
    }

    // use this for the full multiple delete
    func selectionDelete() {
        for ship in selection {
            moc.delete(ship)
        }
        try? moc.save()
        selection = Set<Ship>()
    }
    
    // normally you use this for a single list: delete
    func delete(at offsets: IndexSet) {
        for index: IndexSet.Element in offsets {
            let ship = fetchRequest[index]
            moc.delete(ship)
        }
        try? moc.save()
        
        
    }
}

struct ShipsContentView_Previews: PreviewProvider {
    static var previews: some View {
        ShipsContentView(universe: "")
    }
}
