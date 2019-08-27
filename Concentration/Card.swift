//
//  Card.swift
//  Concentration
//
//  Created by Emma Walker - TVandMobile Platforms - Core Engineering on 02/08/2019.
//  Copyright © 2019 Emma Walker - TVandMobile Platforms - Core Engineering. All rights reserved.
//

import Foundation

struct Card: Hashable
{
    var hashValue: Int {return identifier}
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    var hasBeenFaceUp = false
    
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        Card.identifierFactory += 1
        return Card.identifierFactory
    }
        
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
    
}

// here we have created and object (a card) that has been made hashable - i.e. able to have a key
// it has the following properties; isFaceUp, isMatched, an identifier number, and an identifier factory number that starts as 0
// it has a function that creates a unique identifier and updates the indetifier factroy number
// when initialised the proprty identifier gets set using the function


