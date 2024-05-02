//
//  BookView.swift
//  Bookworm
//
//  Created by Anthony TK on 9/7/23.
//

import SwiftUI

struct BookView: View {
    @Environment(\.managedObjectContext) var moc // call moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.rating, order: .reverse),
        SortDescriptor(\.title)
    ]) var books: FetchedResults<Book> // get all books
    
    @State private var showingAddScreen = false
    
    func delete(at offsets: IndexSet) {
//         delete the objects here and then delete it in the moc
        for index in offsets {
            let book = books[index]
            moc.delete(book)
        }
        try? moc.save()
        
    }
    var body: some View {
        Group{
            List {
                ForEach(books) { book in
                    NavigationLink{
                        //                        Text(book.title ?? "Unknown Title")
                        DetailView(book: book)
                        
                    }
                
                    label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                    .foregroundColor( book.rating == 1 ? .red : .primary)
                                Text(book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    
                }
                .onDelete(perform: delete) // this modifies ForEach element and allows for "swipe delete"

            }
            
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Book", systemImage: "plus")
                    }

                }
                ToolbarItem(placement: .navigationBarTrailing) {        // added to enable easy delete menu in toolbar
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            
            }

        }
        
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookView()
    }
}
