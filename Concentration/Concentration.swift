//
//  Concentration.swift
//  Concentration
//
//  Created by Emma Walker - TVandMobile Platforms - Core Engineering on 02/08/2019.
//  Copyright © 2019 Emma Walker - TVandMobile Platforms - Core Engineering. All rights reserved.
//

import Foundation

struct Concentration {
    
    
    private (set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            
            return cards.indices.filter {cards[$0].isFaceUp}.oneAndOnly
        }
        set {
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in cards")
        
        if !cards[index].isMatched{
            
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                
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
    
    init(numberOfPairsOfCards: Int) {
        
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at lease one pair of cards")
        
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

