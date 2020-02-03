//
//  ViewController.swift
//  Word Garden
//
//  Created by Kelvin Cheng on 2/2/20.
//  Copyright © 2020 Kelvin Cheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessedLetterField: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    
    // class wide variables
    var wordToGuess = "CODE"
    var lettersGuessed = ""
    let maxNumberOfWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var guessCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatUserGuessLabel()
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = true
    }
    
    func formatUserGuessLabel()
    {
        var revealedWord = ""
        lettersGuessed += guessedLetterField.text!
        for letter in wordToGuess
        {
            if lettersGuessed.contains(letter)
            {
                revealedWord = revealedWord + " \(letter)"
            }
            else
            {
                revealedWord += " _"
            }
        }
        revealedWord.removeFirst()
        userGuessLabel.text = revealedWord
    }
    
    func guessALetter()
    {
        formatUserGuessLabel()
        guessCount += 1

        // decrements the wrongGuessesRemaining and shows the next flower image with 1 less petal
        let currentLetterGuessed = guessedLetterField.text!
        if !wordToGuess.contains(currentLetterGuessed)
        {
            wrongGuessesRemaining -= 1
            flowerImageView.image = UIImage(named: "flower\(wrongGuessesRemaining)")
        }
        // stop game if wrongGuessesRemaining = 0
        let revealedWord = userGuessLabel.text!
        if wrongGuessesRemaining == 0
        {
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isHidden = false
        }
        else if !revealedWord.contains("_")
        {
            // youve won a game
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isHidden = false
            guessCountLabel.text = "You've got it! It took you \(guessCount) guesses."
        }
        else
        {
            // update our guess count
            var guess = "guesses"
            if guessCount == 1
            {
                guess = "guess"
            }
            guessCountLabel.text = "You've made \(guessCount) \(guess)."
        }
    }
    
    func updateUIAfterGuess() {
        guessedLetterField.resignFirstResponder()
        guessedLetterField.text = ""
    }
    
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
        updateUIAfterGuess()
 
    }
    
    @IBAction func guessLetterFieldChanged(_ sender: UITextField) {
        if let letterGuessed = guessedLetterField.text?.last
        {
            guessedLetterField.text = "\(letterGuessed)"
            guessLetterButton.isEnabled = true
        }
        else
        {
            // disable the button if no character in the guessedLetterField
            guessLetterButton.isEnabled = false
        }
    }
    
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        guessALetter()
        updateUIAfterGuess()
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        playAgainButton.isHidden = true
        guessedLetterField.isEnabled = true
        guessLetterButton.isHidden = false
        flowerImageView.image = UIImage(named: "flower8")
        wrongGuessesRemaining = maxNumberOfWrongGuesses
        lettersGuessed = ""
        formatUserGuessLabel()
        guessCountLabel.text = "You've made 0 guesses"
        guessCount = 0
    }
    
}

