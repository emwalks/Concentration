//
//  Concentration.swift
//  Concentration
//
//  Created by Emma Walker - TVandMobile Platforms - Core Engineering on 02/08/2019.
//  Copyright © 2019 Emma Walker - TVandMobile Platforms - Core Engineering. All rights reserved.
//


// Concentration is an object that describes how the game is played.
// in MVC principles this is the model
import Foundation

struct Concentration {
    
    // The first thing that happens is an empty array is created. It will contain Card objects.

    private (set) var cards = [Card]()
    
// the game has a property called indexOfOneAndOnlyFaceUpCard. this is a number that is derived by filtering the array and finding the card that is face up using the extension and setting its' index as indexOfOneAndOnlyFaceUpCard

    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            
            return cards.indices.filter {cards[$0].isFaceUp}.oneAndOnly
        }
        set {
            // this means you can access the cards that are face up if you want
            
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }

    
    // chooseCard is a function. it begins with an assertion that the array resulting from cards.indices contains an index otherwise you get the message above.
    // chooseCard states that if the card index is not matched then a new property is defined called matchIndex. matchIndex is set as the indexOfOneAndOnlyFaceUpCard.
    // If matchIndex is not equal to index (ie it's not the same card that has been clicked) then the function checks if the cards match. if they match then the card property is set as isMatched.
    // otherwise the card is set as isFaceUp
    // if matchIndex = index (i.e. you've clicked the same card or it's the forst click then indexOfOneAndOnlyFaceUpCard is set as the index (goes back to turn face up above)
    
    mutating func chooseCard(at index: Int) {
        
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in cards")
        
        if !cards[index].isMatched{
            
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                else {
                    cards[matchIndex].hasBeenFaceUp = true
                }
                cards[index].isFaceUp = true
                
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    // the game is initialised with a countable range from 1 to the property numberOfPairsOfCards (set in ViewController)
    // for each pair a card is created from struct Card and a pair of these cards are added into the array
    // the contents of the cards array is then shuffled
    
    init(numberOfPairsOfCards: Int) {
        
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
            
            cards.shuffle()
            
        }
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first :nil
    }
}





