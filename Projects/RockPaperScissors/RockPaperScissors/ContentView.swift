///Users/anthonytk/Desktop/coding/swift-play/playgrounds/GuessTheFlag/GuessTheFlag/ContentView.swift
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Anthony TK on 8/23/23.
//


// add a pop up when the person exceeds X


import SwiftUI

struct MoveButton: ViewModifier {
    var num: Int
    var selectMove: (Int) -> Void
    var moves: [String]
    let emoji = ["🤛🏾","🤚🏾","✌🏾"]
    func body(content: Content) -> some View {
        Button{
            selectMove(num)
        } label : {
            Text("\(moves[num]) \(emoji[num])")
        }
    }
}
    
extension View {
    func moveButton(num: Int, selectMove: @escaping (Int) -> Void, moves: [String]) -> some View {
        modifier(MoveButton(num: num, selectMove: selectMove, moves: moves))
    }
}


struct ContentView: View {

    private var totalGames = 3
    @State private var curScore = 0
    @State private var numTries = 0
    
    @State private var outcomeTitle: String = ""
    @State private var showOutcome: Bool = false
    @State private var playerMove: String = ""
    @State private var computerMove: String = ""
    
    @State private var showEndMsg: Bool = false
    
    let winningMoves = ["r":"s", "s":"p", "p":"r"]
    let moves: [String] = ["r", "s", "p"]
    
    // this will trigger when you
    // the function will then kick off a series of actions:
    // (1) computer move, (2) did oyu win or lose? (3) calculate score
    func selectMove(num: Int) {
        playerMove = moves[num]
        computerMove = moves[Int.random(in: 0...2)]
        if let winMove = winningMoves[playerMove] {
            if winMove == computerMove {
                curScore += 1
                outcomeTitle = "You Win! \(playerMove) beats \(computerMove)!"
            }
            else {
                outcomeTitle = "You Tie or Lose! \(playerMove) does not beat \(computerMove)!"
            }
            numTries += 1
            showOutcome = true
        }
    }

    func evaluateEnd() {
        if numTries >= totalGames {
            showEndMsg = true
        }
    }
    
    func startNewGame() {
        curScore = 0
        numTries = 0
    }
    
    // will later need to add in whether the game ends
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            Text("Rock-Paper-Scissors!")
                .font(.largeTitle.bold())
            Spacer()
            VStack (spacing: 10){
                Text("Tap a move below and try to beat the computer!")
                Spacer()
                ForEach(0..<3, id: \.self) {num in
                    moveButton(num: num, selectMove: selectMove, moves: moves)
                }
                Spacer()
                Spacer()
                Text("Score: \(curScore), Tries: \(numTries)")
                Spacer()
            }
            
        }
        .alert(outcomeTitle, isPresented: $showOutcome){
            Button("Continue", action: evaluateEnd)
        } message: {
            Text("Your current score is \(curScore).")
        }
        
        .alert("You got \(curScore) out of \(numTries) games. Good job!", isPresented: $showEndMsg){
            Button("Start a new game", action: startNewGame)
        } message: {
            Text("Click to start a new game!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
