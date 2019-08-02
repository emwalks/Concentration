//
//  Concentration.swift
//  Concentration
//
//  Created by Emma Walker - TVandMobile Platforms - Core Engineering on 02/08/2019.
//  Copyright © 2019 Emma Walker - TVandMobile Platforms - Core Engineering. All rights reserved.
//
// this is going to be our Model

import Foundation

//when you build a new class you should think about it's public API and what cars and methods external classes will be able to call
// what does the model of the game concentration look like? i.e. what is our application?
// it is likely to have an array of cards and will need a method that allows you to choose a card

class Concentration {
    
    var cards = [Card]()
    
    
    //this function changes the state of isFaceUp from false to true - i.e. it will now flip the card. the visual component for this is in the controller - updateViewFromModel
    
    func chooseCard(at index: Int) {
        if cards[index].isFaceUp {
            cards[index].isFaceUp = false
        } else {
            cards[index].isFaceUp = true
        }
    }
    
    //because we are passing structs around we are already copying cards so we only need a card, not a second matching card. And we can pass two into the array (which again is a struct which will be copied.
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        //HOMEWORK shuffle the cards
    }
    
}
