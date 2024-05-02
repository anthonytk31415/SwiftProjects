//
//  ContentView.swift
//  Instafilter
//
//  Created by Anthony TK on 9/12/23.
//




import SwiftUI

struct ContentView: View {
    
    @State private var blurAmt = 0.0
    @State private var favSong = "Shake It Off"
    
    @State private var albumDict: [String: [String]] = [
        "1989": ["Welcome to New York", "Style", "Shake It Off", "Wildest Dreams"],
        "Midnights" : ["Lavender Haze", "The Great War", "Would've, Could've, Should've", "Anti-Hero"],
        "Speak Now" : ["I Can See You", "Back To December", "Castles Crumbling"]
    ]
    
    @State private var albums: [String] = ["1989", "Midnights", "Speak Now"]
    
    @State private var showingAbout = false
    @State private var showingMood = false
    @State private var moodColor = Color.blue
    let aboutMsg = "This is a sample project to show multiple views, navbars, and alerts."
    
    
    func getSongs(_ album: String) -> [String] {
        return albumDict[album]!
    }
    
    var body: some View {
        NavigationView{
            Group {
                List {
                    Section{
                        Text("Adjust Lavender Haze:")
                            .blur(radius: blurAmt)
                            .foregroundColor(.purple)
                        Slider(value: $blurAmt, in: 0...20)
                            .onChange(of: blurAmt) { newValue in
                                print("The updated blurAmt is \(blurAmt)")
                                print(albums)
                            }
                    } header: {
                        Text("Settings")
                    }
                    
                    Section{
                        Text(favSong)
                        
                    } header: {
                        Text("Current Favorite Song:")
                    }
                    .foregroundColor(moodColor)
                    
                    
                    Section{
                        ForEach(albums, id: \.self) {album in
                            NavigationLink(album, destination: AlbumDetailView(
                                favSong: $favSong,
                                album: album,
                                songs: albumDict[album]!))
                        }
                    } header: {
                        Text("Albums")
                    }
                    
                    Section {
                        NavigationLink("Album Art: 1989 (Taylor's Version)", destination: CoreImagePlay())
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("About"){
                            showingAbout.toggle()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Mood") {
                            showingMood.toggle()
                        }
                    }
                }
                .alert("About Me", isPresented: $showingAbout) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(aboutMsg)
                }
                
                .confirmationDialog("Change Mood Background", isPresented: $showingMood){
                    Button("Red") { moodColor = .red}
                    Button("Purple") { moodColor = .purple}
                    Button("Pink") { moodColor = .pink}
                    Button("Teal") { moodColor = .teal}
                } message : {
                    Text("Change the mood")
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
