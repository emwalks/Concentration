//
//  Concentration.swift
//  Concentration
//
//  Created by Emma Walker - TVandMobile Platforms - Core Engineering on 02/08/2019.
//  Copyright © 2019 Emma Walker - TVandMobile Platforms - Core Engineering. All rights reserved.
//
// this is going to be our Model and intended to be used by a view controller

import Foundation

//when you build a new class you should think about it's public API and what cars and methods external classes will be able to call
// what does the model of the game concentration look like? i.e. what is our application?
// it is likely to have an array of cards and will need a method that allows you to choose a card

struct Concentration {
    
    //cards has to be public but their properties are managed in the model
    
    private (set) var cards = [Card]()
    
    //this var is to keep track of when only one card is face up
    //this is optional because if there are more than one single card face up the index will be nil
    
    //this is now going to be a computed property:
    //if there is a card that is faceup set foundIndex = nil i.e. there is already a card flipped
    //otherwise set indexOfOneAndOnlyFaceUpCard = foundIndex
    //once this has been returned then set the index as isFaceUp
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            
            //this is an array of index which is int : cards.indices.filter {cards[$0].isFaceUp}
            //oneAndOnly is a var we have used to extend
            
            return cards.indices.filter {cards[$0].isFaceUp}.oneAndOnly
            
            
        }
        set {
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    //this is the fundamental API and so has to be public
    //another way to protect your API is using assertions
    //if the card indices do not contain this index - crash and give this message:
    
    mutating func chooseCard(at index: Int) {
        
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in cards")
        
        //! = opposite of the statement
        //if the card you have chosen is not already matched then do this
        
        if !cards[index].isMatched{
            
            // this is saying if a variable called matchIndex
            // and  index does not equal matchIndex - i.e. you haven't touched the same card
            
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                
                //check if cards match and then mark as matched
                
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    //because we are passing structs around we are already copying cards so we only need a card, not a second matching card. And we can pass two into the array (which again is a struct which will be copied.
    
    init(numberOfPairsOfCards: Int) {
       
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at lease one pair of cards")

        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
            
            // this shuffles the array:
            
            cards.shuffle()
            
        }
    }
}

//This extends anything that is a collection - string, array, dictionary etc
    extension Collection {
        var oneAndOnly: Element? {
            
            //this is a ternary operator
            //this method returns the one and only thing in the collection or it ereturns nil
            //count and first are collection methods
            return count == 1 ? first :nil
        }
    }

