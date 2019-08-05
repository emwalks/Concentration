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
    
    @IBAction func resetGame(_ sender: UIButton) {
        //some code that resets the game
        print("You clicked reset game")
    }
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count+1)/2)
    
    //you can add a property observer to any property to update and execute code e.g. didSet
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    // @IBAction is a directive connecting method to UI
    //func touchCard is a method called touchCard with argument sender
    // _ is the external name (none in this case because this comes from objective-C which doesn't have external names) and internal name sender type UI button
    //an external name is the name callers use
    //if the method had a return value it's syntax would be:
    //func touchCard(_ sender: UIButton) -> Int {}
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
       
        //the index of sender unwraps the optional
       // add an if here because index of returns an optional. So if optional is not set (nil) program won't crash
        //we have re-written this from Lecture 1 to allow the model handle what happens when a card is chosen
        //now we need to update view with the model
        
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card not in card buttons")
        }
    }
    
    //indices gives a countable range from the array
    //this func is going to look at the array of cards in Concentration and make sure the card buttons match in the UI based on game parameters
    
    func updateViewFromModel(){
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
        
    var emojiChoices = ["👻", "🎃", "🦇" ,"😈", "🤡", "☠️", "🧙‍♀️", "👹"]

    //we are going to use a dictionary for this. a dictionary is a data structure where you can look something up and retireve a value
    //here we have defined a dictionary. You specify the key (int) and the value (string):
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        
        // we are going to populate our dictionary with emojis as they are called for
        //arc4random_uniform is a pseudo random number generator from zero up to the upper bound 32 bit unsigned integer (UInt32) not inclusive of the upper bound number
        //however the array's count is an int not an unsigned int
        //swift does not do type conversion! you need toi explicitly convert types
        //to convert you need to create a new thing and initlaise it with the value and type you require
        //UInt32 is a struct with an initialiser that takes an int
        //but randomIndex is an unsigned int nit an int!! so also need to convert whole thing
        // here are two ifs together - if the index is nil and there are emojis left in the array, choose an emji, remove it from the array and put in dictionaryß
        
            if emoji[card.identifier] == nil , emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            }
            
        //Note looking something up in a dictionary returns an optional - this is because what we have looked up may not be there
        // we could use if let here to deal with the optional but instead we are going to check if the result of looking up the dictionary is nil before we return anything
        //below is a special operator instead of using if else because it's so commonly used
        // This says return  emoji[card.identifier] but if it’s nil return "?":
        
        return emoji[card.identifier] ?? "?"
        
        }
    }

