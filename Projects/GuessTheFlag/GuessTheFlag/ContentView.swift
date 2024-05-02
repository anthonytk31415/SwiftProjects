//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Anthony TK on 8/22/23.
//

// vstack stacks stuff one another
// - default aligns to center
// - alignment: .leading --> aligns to the left
// hstack does things horizontally
// spacer pushes things down or up in ratios
// spacing

// zstack: in z-space; draws top to bottom

// provide frame modifier

import SwiftUI

struct LargeWhiteTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.white)
    }
}

struct LargeSemibold: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.weight(.semibold))
    }
}

struct FlagImage: ViewModifier {
    var number: Int
    var countries: [String]
    var animationAmt: Double
    var opacityAmt: Double
    func body (content: Content) -> some View {
        Image(countries[number])
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
            .rotation3DEffect(.degrees(animationAmt), axis: (x: 0, y: 1, z: 0))
            .opacity(opacityAmt)
    }
}




extension View {
    func flagImageUsed(number: Int, countries: [String], animationAmt: Double, opacityAmt: Double) -> some View {
        modifier(FlagImage(number: number, countries: countries, animationAmt: animationAmt, opacityAmt: opacityAmt))
    }
    
    func LargeSemiBolded () -> some View {
        modifier(LargeSemibold())
    }
    
    func LargeWhiteTitled () -> some View {
        modifier(LargeWhiteTitle())
    }
}

struct ContentView: View {
    @State private var numTries = 0
    private let maxTries = 3
    
    @State private var showingEnd = false
    
    @State private var curScore = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var animationAmtArr: [Double] = [0.0, 0.0, 0.0]
    @State private var opaqueFlagArr: [Double] = [1.0, 1.0, 1.0]

    var body: some View {
        ZStack {
            //            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
            //                .ignoresSafeArea()
            
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)],
                           center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack {
                Spacer()        // note that the spacers will divide in ratios of the spacers
                
                Text("Guess the Flag")
//                    .font(.largeTitle.bold())
//                    .foregroundColor(.white)
                    .LargeWhiteTitled()
                    

                VStack (spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary) // note that it is background plus contrast
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .LargeSemiBolded()
                    }
                    ForEach(0..<3) { number in
                        Button{
                            flagTapped(number)
                        } label: {
                            flagImageUsed(number: number, countries: countries, animationAmt: animationAmtArr[number], opacityAmt: opaqueFlagArr[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(curScore); Tries \(numTries)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(curScore)")
        }
        
        .alert("You got \(curScore) flags out of \(numTries) tries!", isPresented: $showingEnd){
            Button("Start a new game", action: startNewGame)
        } message: {
            Text("Click below to start a new game!")
        }
    
    }
    
    func flagTapped(_ number: Int){
        withAnimation{
            animationAmtArr[number] += 360
        }
        numTries += 1
        if number == correctAnswer {
            curScore += 1
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong! That is the flag of \(countries[number]). "
        }
        showingScore = true
        
        
        for i in 0...2 {
            if i != number {
                withAnimation{
                    opaqueFlagArr[i] = 0.2
                }
            }
        }
    }
    
    func askQuestion() {
        if numTries >= maxTries {
            showingEnd = true
        } else {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            withAnimation{
                opaqueFlagArr = [1.0, 1.0, 1.0]
            }
        }
    }
    
    func startNewGame() {
        numTries = 0
        curScore = 0
        withAnimation{
            opaqueFlagArr = [1.0, 1.0, 1.0]
        }
        
        askQuestion()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
