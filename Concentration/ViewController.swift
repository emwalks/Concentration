//
//  ViewController.swift
//  Concentration
//
//  Created by Emma Walker - TVandMobile Platforms - Core Engineering on 02/08/2019.
//  Copyright © 2019 Emma Walker - TVandMobile Platforms - Core Engineering. All rights reserved.
//

//brings in UIKIt iOs framework for sliders, buttons etc (cocoa touch)

import UIKit

//declaration of a class ViewController with superclass UIViewController via inheritance.
//ViewController inherits all the tooling in UIKit

class ViewController: UIViewController
{
    
    //this var game is the link from my Controller here to the Model held in Concentration.swift
    //the lazy var allows us to wait to initilise this var until cardButtons has been initialised
    //a lazy var cannot have property observer
    
    //this is our model. Often view controllers models are public
    // i.e. you give a model to a view controller and it displays it
    //however in this case we want it to be private because number of pairs of cards in the game is tied to the UI
    //to make it usable and public we would need to define numberOfPairsOfCards in another way
    
    private lazy var game: Concentration =
        Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    //this is a computed property that is read only. If it is "get" only you do not need the get syntax
    //this can be public because it is read only
    
    var numberOfPairsOfCards: Int{
        return (cardButtons.count+1)/2
        
    }
    
    //you can add a property observer to any property to update and execute code e.g. didSet
    //the initialisation does not envoke the didSet so set the 
    
    private (set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes:[NSAttributedString.Key:Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    // @IBAction is a directive connecting method to UI
    //func touchCard is a method called touchCard with argument sender
    // _ is the external name (none in this case because this comes from objective-C which doesn't have external names) and internal name sender type UI button
    //an external name is the name callers use
    //if the method had a return value it's syntax would be:
    //func touchCard(_ sender: UIButton) -> Int {}
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        
        //the index of sender unwraps the optional
        // add an if here because index of returns an optional. So if optional is not set (nil) program won't crash
        //we have re-written this from Lecture 1 to allow the model handle what happens when a card is chosen
        //now we need to update view with the model
        
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card not in card buttons")
        }
    }
    
    //indices gives a countable range from the array
    //this func is going to look at the array of cards in Concentration and make sure the card buttons match in the UI based on game parameters
    
    private func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                
                // this sets the background clear if the card is facedown and is matched
                
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
    }
    
    
    private let halloweenTheme = ["👻", "🎃", "🦇" ,"😈", "🤡", "☠️", "🧙‍♀️", "👹"]
    
    private let animalsTheme = ["🦁", "🐸", "🐝" ,"🦋", "🐙", "🦈", "🐻", "🐞"]
    
    private let christmasTheme = ["⛄️", "🥃", "🎄", "🎅🏻", "🎁", "🦌", "⛷", "🦃"]
    
    private let natureTheme = ["🌈", "🌵", "🍄", "🌸", "☀️", "❄️", "🍁", "🐚"]
    
    private let flagsTheme = ["🇮🇪", "🇬🇧", "🇳🇴", "🇨🇭", "🇫🇷", "🇮🇳", "🇪🇸", "🇧🇬"]
    
    private let foodTheme = ["🍏", "🍊", "🍓", "🍋", "🍉", "🍇", "🍍", "🥕"]
    
    private lazy var themes: [[String]] = [halloweenTheme, animalsTheme, christmasTheme, natureTheme, flagsTheme, foodTheme]
    
    private lazy var emojiChoices = themes.randomElement()!
    
    //we are going to use a dictionary for this. a dictionary is a data structure where you can look something up and retireve a value
    //here we have defined a dictionary. You specify the key (int) and the value (string):
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
        
        // we are going to populate our dictionary with emojis as they are called for
        //arc4random_uniform is a pseudo random number generator from zero up to the upper bound 32 bit unsigned integer (UInt32) not inclusive of the upper bound number
        //however the array's count is an int not an unsigned int
        //swift does not do type conversion! you need toi explicitly convert types
        //to convert you need to create a new thing and initlaise it with the value and type you require
        //UInt32 is a struct with an initialiser that takes an int
        //but randomIndex is an unsigned int nit an int!! so also need to convert whole thing
        // here are two ifs together - if the index is nil and there are emojis left in the array, choose an emji, remove it from the array and put in dictionaryß
        
        //we have removed the .identifer because we would like the card to  be the identifier
        //use Card directly as the key into our emoji doctioary
        //by making card hashable we can compare Cards directly since they will bwe equatable
        
        
        if emoji[card] == nil , emojiChoices.count > 0 {
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
            print(emojiChoices)
        }
        
        //Note looking something up in a dictionary returns an optional - this is because what we have looked up may not be there
        // we could use if let here to deal with the optional but instead we are going to check if the result of looking up the dictionary is nil before we return anything
        //below is a special operator instead of using if else because it's so commonly used
        // This says return  emoji[card.identifier] but if it’s nil return "?":
        
        return emoji[card] ?? "?"
    }
    
    
    @IBAction private func resetGame(_ sender: UIButton) {
        //need to reset: game, emojis and flipcount
        
        game = Concentration(numberOfPairsOfCards: (cardButtons.count+1)/2)
        flipCount = 0
        emojiChoices = themes.randomElement()!
        updateViewFromModel()
        
    }
    
}

// we have extended our int to have an arc4random property so the emoji func does not have to manage this.

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
