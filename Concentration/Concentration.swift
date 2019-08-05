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
    
    //this var is to keep track of when only one card is face up
    //this is optional because if there are more than one single card face up the index will be nil
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {

        //! = opposite of the statement
        //if the card you have chosen is not already matched then do this
        
        if !cards[index].isMatched{
            // this is saying if a variable called matchIndex
            // and  index does not equal matchIndex - i.e. you haven't touched the same card
            
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                
                //check if cards match and then mark as matched
                
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
           
            } else {
                
                // either no cards or 2 cards are face up
                
                for flipDpwnIndex in cards.indices {
                    cards[flipDpwnIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
    }
    
    //because we are passing structs around we are already copying cards so we only need a card, not a second matching card. And we can pass two into the array (which again is a struct which will be copied.
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
           let card = Card()
            cards += [card, card]
            
            // this shuffles the array:

            cards.shuffle()
        
        }
        
        // TODO: add a reset game button
    }
    
}
