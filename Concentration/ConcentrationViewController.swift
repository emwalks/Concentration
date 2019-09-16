//
//  ViewController.swift
//  Concentration
//
//  Created by Emma Walker - TVandMobile Platforms - Core Engineering on 02/08/2019.
//  Copyright © 2019 Emma Walker - TVandMobile Platforms - Core Engineering. All rights reserved.
//

import UIKit

//this is the controller in MVC principles

class ConcentrationViewController: UIViewController
{
   // this sets a property of type Concentration game and the argument number of Pairs of Cards comes from the var numberOfPairsOfCards
    
    private lazy var game: Concentration =
        Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    // the numberOfPairsOfCards property is set as the number of (cardbuttons +1) /2. The +1 is in case there are an uneven number of card buttons
    var numberOfPairsOfCards: Int{
        return (cardButtons.count+1)/2
    }
    
    // this sets a property called flipcount and everytime the flipCount is updated the updateFlipCountLabel function is called
    private (set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    // this function sets the attributes for the text on screen and assigns them to the var
    private func updateFlipCountLabel() {
        let attributes:[NSAttributedString.Key:Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    // this is the flipcount label itself which calls the function above
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
   
    // this is the scorecount label itself which calls the function above
    private (set) var scoreCount = 0 {
        didSet {
            updateScoreCountLabel()
        }
    }
    
    // this is where the properties of the on screen text is set for the score counter
    private func updateScoreCountLabel() {
        let attributes:[NSAttributedString.Key:Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Score: \(scoreCount)", attributes: attributes)
        scoreCountLabel.attributedText = attributedString
    }
    
    //this is the scorecounter itself
    @IBOutlet private weak var scoreCountLabel: UILabel!{
        didSet {
            updateScoreCountLabel()
        }
    }
    
    //this is an array of buttons
    @IBOutlet private var cardButtons: [UIButton]!
    
    // this is function which is called when a card is clicked
    // it adds 1 to the flipcount {which in turn calls the updateFlipCountLabel()}
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        
        //this says if the cardNumber = cardButton.index then calls chooseCardFunction in the game Concentration and calls updateViewFromModel function below
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card not in card buttons")
        }
    }
    
    // this is a function that sets the initial scoreCount = 0 everytime it is called then iterively counts how many cards are market as isMatched (each pair = +2)
    // if the card is faceUp an emoji is put on it from the emoji(for: card) function and the background is set to white. Otherwise it is set to a space
    // if the card is matched it sets the background to clear
    // for every card that is matched the score count is incremented to +1 (+2 for the pair)
    
    
    private func updateViewFromModel(){
        scoreCount = 0
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                //UIControl.State.normal this is talking about the action on the button
                //more later
                button.setTitle("", for: UIControl.State.normal)
                                
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0) : #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
                if card.isMatched{
                    scoreCount += 1
                }
                
                if card.hasBeenFaceUp {
                    scoreCount -= 1
                }
            }
        }
    }
    
    //going to add a theme picker
    
    var theme: Array<String>? {
        didSet{
            emojiChoices = theme ?? [""]
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    
    private let halloweenTheme = ["👻", "🎃", "🦇" ,"😈", "🤡", "☠️", "🧙‍♀️", "👹"]
    
    private let animalsTheme = ["🦁", "🐸", "🐝" ,"🦋", "🐙", "🦈", "🐻", "🐞"]
    
    private let christmasTheme = ["⛄️", "🥃", "🎄", "🎅🏻", "🎁", "🦌", "⛷", "🦃"]
    
    private let natureTheme = ["🌈", "🌵", "🍄", "🌸", "☀️", "❄️", "🍁", "🐚"]
    
    private let flagsTheme = ["🇮🇪", "🇬🇧", "🇳🇴", "🇨🇭", "🇫🇷", "🇮🇳", "🇪🇸", "🇧🇬"]
    
    private let foodTheme = ["🍏", "🍊", "🍓", "🍋", "🍉", "🍇", "🍍", "🥕"]
    
    // this is an array of arrays of strings
    private lazy var themes: [[String]] = [halloweenTheme, animalsTheme, christmasTheme, natureTheme, flagsTheme, foodTheme]
    
    // this chooses one element (array) at "random" from the array of arrays
    private lazy var emojiChoices = themes.randomElement()!
    
    // this is a dictionary called emoji. The dictionary is made up of keys which are cards and associated strings
    private var emoji = [Card:String]()
    
    // this function returns a String.
    // if the dictionary emoji above is empty (?) and emojiChoices > 0 (i.e. there are emojis left in the array) then an emoji is placed in the string element of the dictionary and removed from the emojiChoices array at "random" using the extension below
    // then the emoji is returned or the sring ? is returned i.e. all emojis used up
    private func emoji(for card: Card) -> String {
  
        if emoji[card] == nil , emojiChoices.count > 0 {
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
            print(emojiChoices)
        }
       
        return emoji[card] ?? "?"
    }
    
    @IBAction private func resetGame(_ sender: UIButton) {
      
        game = Concentration(numberOfPairsOfCards: (cardButtons.count+1)/2)
        flipCount = 0
        scoreCount = 0
        emojiChoices = themes.randomElement()!
        updateViewFromModel()
        
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
