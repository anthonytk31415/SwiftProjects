//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Anthony TK on 9/10/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    

    var countries: [String] = [
        "estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia",
        "spain", "uk", "us"
    ]
    var score = 0
    var correctAnswer = 0
    var numGuesses = 0
    var curGuess = ""
    let maxGames = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for button in [button1, button2, button3] {
            button!.layer.borderWidth = 1
            button!.layer.borderColor = UIColor.lightGray.cgColor
        }
        
        askQuestion(action: nil)
    }

    func renderTitle() {
        title = "\(countries[correctAnswer].uppercased()), Score: \(score), Response: \(curGuess)"
    }
    
    
    func askQuestion(action: UIAlertAction!) {
        countries.shuffle()
        
        for (i, button) in [button1, button2, button3].enumerated() {
            button!.setImage(UIImage(named: countries[i]), for: .normal)
        }
        
        correctAnswer = Int.random(in: 0...2)
        renderTitle()
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        if sender.tag == correctAnswer {
            curGuess = "Correct"
            score += 1

        } else {
            curGuess = "Wrong"
            score -= 1
        }
        numGuesses += 1
        endGame()
        renderTitle()
        
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion ))
        present(ac, animated: true)
        endGame()
        curGuess = ""
    }
    
    
    func endGame(){
        if numGuesses == maxGames {
            let ac = UIAlertController(
                title: "The Game is Over",
                message: "Your final score = \(score)! Good job!!",
                preferredStyle: .alert)
            present(ac, animated: true)
        }
    }
    
}

