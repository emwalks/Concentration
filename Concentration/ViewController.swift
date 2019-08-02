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
    
    var emojiChoices = ["👻", "🎃", "🎃" ,"👻"]
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
       
        //the index of sender unwraps the optional
       // add an if here because index of returns an optional. So if optional is not set (nil) program won't crash
        
        if let cardNumber = cardButtons.index(of: sender){
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        } else {
            print("chosen card not in card buttons")

        }
    }
    
    //this is a function with 2 parameters emoji type string and button type UI button
    //the external names for these arguments are withEmoji and on
    //this function will be used when touchCard is executed
    //the function checks if the text of the card (currentTitle) is an emoji (ie face up). if it is it sets the title to blank and the background to orange
    //else it flips it face up
    
    func flipCard(withEmoji emoji:String, on button: UIButton){
        
        //light debugging to see when a card is clicked which emoji is being used:
        //print("flipCard(withEmoji: \(emoji))")
        
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
}

