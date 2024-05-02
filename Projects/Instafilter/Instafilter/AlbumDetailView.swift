//
//  AlbumDetailView.swift
//  Instafilter
//
//  Created by Anthony TK on 9/12/23.
//

import SwiftUI

struct AlbumDetailView: View {
    @Binding var favSong: String
    
    let album: String
    let songs: [String]
    
    var body: some View {
        List{
            Section {
                Text(favSong)
            } header: {
                Text("Current Favorite Song")
            }
            
            
            Section{
                Text(album)
                    .font(.largeTitle)
            } header: {
                Text("Album")
            }
            
            Section {
                ForEach(songs, id: \.self) { song in
                    Button(song, action: {setSong(song)})
                }
            } header: {
                Text("Songs")
            }
        }
    }
    func setSong (_ song: String) {
        favSong = song
    }
}
//
//struct AlbumDetailView_Previews: PreviewProvider {
//    @State private var favSong = "22"
//
////    let songs = ["Wildest Dreams", "Clean", "New Romantics"]
//    static var previews: some View {
//        AlbumDetailView(favSong: $favSong, album: "1989", songs: ["Wildest Dreams", "Clean", "New Romantics"])
//    }
//}
