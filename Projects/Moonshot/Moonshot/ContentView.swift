//
//  ContentView.swift
//  Moonshot
//
//  Created by Anthony TK on 8/27/23.
//

import SwiftUI

// encode flat data like arrays and dict with Codable;
//

// First step: (1) load astronaut data, and (2) load mission data

// Notes:
// when we changed the generic Bundle to a T, we have to specify
// the type

// Second step: lets create grid of


struct ListMissions: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    var body: some View {
        List(missions) {mission in
            NavigationLink{
                MissionView(mission: mission, astronauts: astronauts)
            } label: {
                HStack{
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding()
                    Spacer()
                    VStack(alignment: .leading){
                        
                        Text(mission.displayName)
                            .font(.caption)
                            .foregroundColor(.white)
                        Text(mission.formattedLaunchDate)
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.5))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.lightBackground)
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))      // this modifies the textbox
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.lightBackground)
                )
            }
            .listRowBackground(Color.darkBackground)        // lists and grids have different ways to modify their backgrounds
        }
        .listStyle(.plain)                                  // this is required to make it look like the grid
    }
}

struct CustomGrid: View {
    let columns: [GridItem]
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink{
                        //                                Text("blah")
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            VStack {
                                Text(mission.displayName)
                                    .font(.caption)
                                    .foregroundColor(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5)) // have blueish background come through for difference
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical)
                            .background(.lightBackground)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))        // modifies the textbox
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                    }
                }
            }
            .padding([.horizontal, .bottom]) // important to pad the thing inside the scroll view so it has division with the edges
        }
    }
}


struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150)) // squeeze as many items as you can in the given space
    ]
    
    
    @State private var gridToggle = false
    private var gridToggleText: String {
        if gridToggle {
            return "Toggle List"
        } else {
            return "Toggle Grid"
        }
    }
    var body: some View {
        NavigationView{
            Group {
                if gridToggle {
                    CustomGrid(columns: columns, missions: missions, astronauts: astronauts)
                } else {
                    ListMissions(missions: missions, astronauts: astronauts)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)        // always use dark mode; but what makes it dark?
            .toolbar{
                Button(gridToggleText){
                    gridToggle.toggle()
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
