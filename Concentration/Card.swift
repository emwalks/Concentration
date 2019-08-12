//
//  Card.swift
//  Concentration
//
//  Created by Emma Walker - TVandMobile Platforms - Core Engineering on 02/08/2019.
//  Copyright © 2019 Emma Walker - TVandMobile Platforms - Core Engineering. All rights reserved.
//

import Foundation

//struct in similar to a class except it has no inheritence and will always get copied - not a reference type, is a value type
//this is the model of the card i.e. how it works not how it looks

struct Card {
    
    //at the moment these need to be public
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    //although the static func and var are in the type Card, they will not be passed to an instance of a card. they are utility/global functions
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        Card.identifierFactory += 1
        return Card.identifierFactory
    }
    
    //init's tend to have same internal and external name.
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
    
}

