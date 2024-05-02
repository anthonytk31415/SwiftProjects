//
//  ContentView.swift
//  TimesTable
//
//  Created by Anthony TK on 8/25/23.
//

import SwiftUI


struct GameParameters: View {
    
    // binding is required to let the child GameParams know that it is a variable that needs to accommodate for change. otherwise it treats teh var like a const
    @Binding var minTable: Int
    @Binding var maxTable: Int
    @Binding var numFlashes: Int
    
    var body: some View {
        VStack{
            HStack{
                Stepper("Lower range of multiplication table:", value: $minTable, in: 2...20, step: 1)
                Text("\(minTable)")
                    .font(.title)
            }
            
            HStack{
                Stepper("Upper range of multiplication table:", value: $maxTable, in: 2...20, step: 1)
                Text("\(maxTable)")
                    .font(.title)
            }

            HStack{
                Stepper("Number of flashes:", value: $numFlashes, in: 2...20, step: 1)
                Text("\(numFlashes)")
                    .font(.title)
            }
        }
    }
}


struct ContentView: View {
    
    // vars for the timesTable game
    @State private var minTable:Int = 2
    @State private var maxTable:Int = 9
    @State private var numFlashes:Int = 3

    @State private var toggleGameSettings = true
    @State private var curScore: Int = 0
    @State private var numAttempts: Int = 0
    
    @State private var response = ""
    
    @State private var showingError = false
    @State private var errorMessage = ""
    @State private var errorTitle = ""
    
    @State private var num1 = 2
    @State private var num2 = 3
    @State private var quizQuestion = ""
    @State private var answer = ""
    
    @State private var showingRes = false
    @State private var resTitle = ""
    @State private var resMessage = ""
    
    @State private var showingEnd = false
    @State private var endTitle = ""
    @State private var endMessage = ""
    
    func commenceGame() {
        // run error checks and if they're all satisfied, then start game

        if checkBoundsErrorCheck() == true {
            showingError = true
            errorMessage = "Can't start game:"
            errorTitle = "Your Lower Range must be less than or equal to the Upper Range."
            return
        }

        toggleGameSettings = false
        resetScore()
        initiateQuestion()
    }
    
    func resetScore(){
        curScore = 0
        numAttempts = 0
        answer = ""
    }
    
    func startNewGame() {
        toggleGameSettings = true

    }
    
    func initiateQuestion() {
        num1 = Int.random(in: minTable...maxTable)
        num2 = Int.random(in: minTable...maxTable)
        quizQuestion = "\(num1) X \(num2) ?"
        answer = ""
    }
    
    
    // if gameSet = false -> set up game; else -> play game

    // errors
    func checkBoundsErrorCheck() -> Bool  {
        return minTable > maxTable
    }
    
    func evaluateQuestion() {
        // check if the response is valid (if it's empty) ; if not then send an error message
        guard answer != "" else {
            errorTitle = "Invalid input"
            errorMessage = "Please enter a response."
            showingError = true
            return
        }
//        let res = Int(answer)
        if Int(answer) == num1 * num2 {
            curScore += 1
            resTitle = "Correct!"
            resMessage = "Great Job!"
            showingRes = true
        } else {
            resTitle = "Wrong!"
            resMessage = "The correct answer is \(num1 * num2). "
            showingRes = true
        }
        
        // increase score and attemps
        numAttempts += 1
        
        // evaluate whether the game ends, or you pull a new question
        if numAttempts == numFlashes {
            endTitle = "The game has ended!"
            endMessage = "Your score is \(curScore) / \(numAttempts). "
            showingEnd = true
        } else {
            initiateQuestion()
        }
    }
    
    
    var body: some View {
        VStack {
            NavigationView{

                    List{
                        if toggleGameSettings {
                            Section {
                                GameParameters(minTable: $minTable, maxTable: $maxTable, numFlashes: $numFlashes)
                                
                                VStack{
                                    Button("Let's go!", action: commenceGame)
                                        .frame(alignment: .center)
                                }
                            }
                        }
                        
                        if !toggleGameSettings {
                            Section {
                                Text("Times Table Game goes here")
                                Text(quizQuestion)
                                TextField("Enter the answer here", text: $answer)
                                    .keyboardType(.numberPad)
                                    .padding()
                                Button("Submit", action: evaluateQuestion)
                                Text("Score: \(curScore) out of \(numAttempts) attempts.")
                                
                            }
                        }
                    }
                    
                    .toolbar(){
                        ToolbarItem(placement: .navigationBarLeading){
                            Text("Times Tables")
                        }
                        ToolbarItem(placement: .navigationBarTrailing){
                            Button("Start New Game", action: startNewGame)
                        }
                    }
                    .alert(errorTitle, isPresented: $showingError) {
                        Button("OK", role: .cancel) { }
                    
                    } message: {
                        Text(errorMessage)
                    }
                    .alert(resTitle,  isPresented: $showingRes) {
                        Button("Continue") { }
                    } message : {
                        Text(resMessage)
                    }
                
                    .alert(endTitle,  isPresented: $showingEnd) {
                        Button("Start new game", action: startNewGame)
                    } message : {
                        Text(endMessage)
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
