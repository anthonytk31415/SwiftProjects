//
//  WizardsView.swift
//  CoreDataProject
//
//  Created by Anthony TK on 9/9/23.
//

import SwiftUI

struct WizardsView: View {
    @Environment(\.managedObjectContext) var moc    
    @FetchRequest(sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
    var body: some View {
        Group {
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknown")
            }
            Button ("Add") {
                let wizard = Wizard(context: moc)
                wizard.name = "Harry Potter"
            }
            
            Button("Save") {
                do {
                    try moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct WizardsView_Previews: PreviewProvider {
    static var previews: some View {
        WizardsView()
    }
}
