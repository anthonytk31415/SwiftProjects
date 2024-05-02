//
//  DetailView.swift
//  Bookworm
//
//  Created by Anthony TK on 9/7/23.
//
import CoreData
import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    
    let book: Book
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "Y-MM-dd"
        let res = dateFormatter.string(from: date)
        return res
    }
    
    func deleteBook() {
        moc.delete(book)
        dismiss()
    }
    
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing){
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()

                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            

            Text(book.author ?? "Unknown Author")
                .font(.title)
                .foregroundColor(.secondary)
            Text(book.review ?? "No review")
                .padding()
            Text(book.genre ?? "Fantasy")
                .font(.title)
                .foregroundColor(.secondary)
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
            Text("Date created: \(formatDate(date: book.date ?? Date.now))")
                .font(.largeTitle)
            
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        
        // alert to delete the book from the row
        .alert("Delete book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure?")
        }
        // toolbar
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete the book", systemImage: "trash")
            }
        }
    }
}

//
//struct DetailView_Previews: PreviewProvider {
//    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//
//    static var previews: some View {
//        let book = Book(context: moc)
//        book.title = "Test book"
//        book.author = "Test author"
//        book.genre = "Fantasy"
//        book.rating = 4
//        book.review = "This was a great book; I really enjoyed it."
//
//        return NavigationView {
//            DetailView(book: book)
//        }
//    }
//}
