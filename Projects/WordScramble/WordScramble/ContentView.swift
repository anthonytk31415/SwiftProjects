//
//  ContentView.swift
//  WordScramble
//
//  Created by Anthony TK on 8/23/23.
//

// diff betw try and do try catch
import SwiftUI


// useful stuff
struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var score = 0
    
    var body: some View {
        NavigationView {
            List{
                Section {
                    HStack{
                        TextField("Enter your word", text: $newWord)
                            .autocapitalization(.none)
                        
                    }
                }
                Section {
                    ForEach(usedWords, id: \.self) {word in     // id: \.self: every item in in the list is unique
                        HStack {
                            Image(systemName: "\(word.count).circle.fill")
                            Text(word)
                        }
                    }
                }
            }
            .toolbar(){
                ToolbarItem(placement: .navigationBarLeading){
                    Text("Score: \(score)")
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("New Game", action: newGame)
                }

                

                
            }
            
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }


    }
    
    // lowercase, remove white space, has at least 1 char else exit,
    // insert word entered at 0 in array, set new word = ""
    func addNewWord() {
        let ans = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard ans.count > 0 else { return }
        // extra validations later
        
        guard isOriginal(word: ans) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        
        guard isPossible(word: ans) else {
            wordError(title: "Word not possible!", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        
        guard isReal(word: ans) else {
            wordError(title: "Word not recognized", message: "You can't make up words, you know!")
            return
        }
        
        guard notSameWord(word: ans) else {
            wordError(title: "Word is the same as the given word \(rootWord).", message: "The word has to be a subset of the given word.")
            return
        }
        
        guard ans.count > 2 else {
            wordError(title: "Word must be 3 characters or more!", message: "Try harder - you can do it!")
            return
        }
        
        doScore(word: ans)
        
        withAnimation{                      // add some animation to the insertion and creation
            usedWords.insert(ans, at: 0)
            newWord = ""
        }
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n") // split by returns and return an array
                rootWord = allWords.randomElement() ?? "silkworm" // should be never empty
                return
             }
        }
        // trigger fatal error
        fatalError("Could not load start.txt from bundle.")
    }

    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        // ns range to scan the entire string
        let checker = UITextChecker()       // initiate the checker
        let range = NSRange(location: 0, length: word.utf16.count)      // give it  range
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")     // give it the right parameters
        // look for any wrong words
        return misspelledRange.location == NSNotFound       // see if NSNotFound triggered
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func notSameWord(word: String) -> Bool {
        return word != rootWord
    }

    func newGame() {
        usedWords = [String]()
        startGame()
    }
    
    func doScore(word: String) {
        score += word.count
    }
    
}


// recall: line break = "\n"

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
