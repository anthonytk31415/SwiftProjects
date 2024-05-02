//
//  ContentView.swift
//  Bookworm
//
//  Created by Anthony TK on 8/31/23.
//

import SwiftUI

struct ContentView: View {
        
    // (4) intiate student dataset from Coredata
    @Environment(\.managedObjectContext) var moc    // required to call on MOC in each view
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student> // initiates the Student dataset from CoreData; make a new fetch with no sorting
    
    
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Main Menu")
                    .font(.title)
                Spacer()
                List{
                    NavigationLink("Examples of Binding and TextEditor", destination: EarlyExamples())
                    NavigationLink("Core Data Examples", destination: CoreDataEx())
                    NavigationLink("Books", destination: BookView())
                }
                Spacer()
                
                List(students) { student in
                    Text(student.name ?? "Unknown") // student.name is an optional no matter; they mean different things and is a bit annoying
                }
                
                Button("Add") {
                    let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                    let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

                    let chosenFirstName = firstNames.randomElement()!
                    let chosenLastName = lastNames.randomElement()!
                    
                    let student = Student(context: moc)
                    student.id = UUID()
                    student.name = "\(chosenFirstName) \(chosenLastName)"

                    try? moc.save()     // we'll ignore errors b/c they'll be no errors
                    
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
//
//
//@StateObject private var dataController = DataController()
//
//var body: some Scene {
//    WindowGroup {
//        ContentView()
//            .environment(\.managedObjectContext, dataController.container.viewContext)
//    }
