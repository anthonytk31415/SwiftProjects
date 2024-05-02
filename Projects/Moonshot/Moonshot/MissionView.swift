//
//  MissionView.swift
//  Moonshot
//
//  Created by Anthony TK on 8/28/23.
//

import SwiftUI

// use GeometryReader to wisely use the canvas space

struct CustomDivider: View {
    var body: some View {
        Rectangle()     // looks great with vstack
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}


struct MissionHighlights: View {
    let mission: Mission
    
    var body: some View {
        VStack(alignment: .leading) {
            CustomDivider()
            
            HStack{
                Text("Mission Launch Date:")
                Spacer()
                Text("\(mission.formattedLaunchDate)")
                Spacer()
            }
            
            CustomDivider()
            
            Text("Mission Highlights")
                .font(.title.bold())
                .padding(.bottom, 5)
            Text(mission.description)
            
            CustomDivider()     // looks great with vstack
            
            Text("Crew")
                .font(.title.bold())
                .padding(.bottom, 5)
            
        }
        .padding(.horizontal)
    }
}
struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
//    let missionDate = 
    
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {    // center alignment
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)
                    
//                    Divider() // breaks up stuff, but you can draw your own b/c this one isn't customizable
//                    Rectangle()     // looks great with vstack
//                        .frame(height: 2)
//                        .foregroundColor(.lightBackground)
//                        .padding(.vertical)
                    // note we replace rectangle() block with CustomDivider()
                    
                    // innie has leading alignment
                    MissionHighlights(mission: mission)

                    
                    ScrollView(.horizontal, showsIndicators: false) { // horizontal scrolling with the disable showIndicators
                        HStack{
                            ForEach(crew, id: \.role) { crewMember in
                                NavigationLink{
//                                    Text("crew member detail")
                                    AstronautView(astronaut: crewMember.astronaut)
                                } label: {
                                    HStack{
                                        Image(crewMember.astronaut.id)
                                            .resizable()
                                            .frame(width: 104, height: 72) // correct ratio of image size
                                            .clipShape(Capsule())
                                            .overlay(
                                                Capsule()   // kind of puts a white border around the images
                                                    .strokeBorder(.white,
                                                                  lineWidth: 1)
                                            )
                                        
                                        VStack(alignment: .leading) {

                                            Text(crewMember.astronaut.name)
                                                .foregroundColor(.white)
                                                .font(.headline)
                                            Text(crewMember.role)
                                                .foregroundColor(.secondary)
                                                
                                        }
                                    }
                                    .padding(.horizontal) // gives a bit of horizontal padding to the image screens
                                    
                                    // note that the hstack looks nicer edge-to-edge wtihout the padding from the vstack
                                }
                            }
                        }
                    }
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    
    // find astronaunts of a crew
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
            
        }
    }
    
    
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
