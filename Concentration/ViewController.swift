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
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
    }
        
        var emojiChoices = ["👻", "🎃", "🦇" ,"😈"]

        func emoji(for card: Card) -> String {
            return "?"
        }
    }

