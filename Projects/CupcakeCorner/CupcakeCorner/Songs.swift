//
//  Songs.swift
//  CupcakeCorner
//
//  Created by Anthony TK on 8/30/23.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
    
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

// async function: await ; func that goes to sleep to wait for work to complete so other stuff can commence when
//  that other stuff happens (like waiting for stuff to get sent to you
// runs fully from start to finish

struct Songs: View {
    @State private var results = [Result]()

    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .task {
            // need the await here
            await loadData()
            // could take place below here at some point;
        }
    }
    
    // notice the new async keyword
    // mark it with await
    // mark views with .task in the view
    func loadData() async {
        // step 1: create url: itunes each api
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        // step 2: fetch data for the url
        do {
            // try await triggers the try error catching AND the "promise" structure
            let (data, _) = try await URLSession.shared.data(from: url)
        // step 3: then decode that result
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print("invalid data")
        }
    }
}

struct Songs_Previews: PreviewProvider {
    static var previews: some View {
        Songs()
    }
}
