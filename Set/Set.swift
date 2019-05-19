//
//  Set.swift
//  Set
//
//  Created by Bronson Knowles on 5/17/19.
//  Copyright © 2019 Bronson Knowles. All rights reserved.
//

import Foundation

/// TODO: Update documentation as struct changes.
/// A game of Set.
/// Keeps track of the displayed cards, selected cards, and score.
struct Set {
    var displayedCards = [Card]()
    private var cardDeck = SetDeck()
    
    init() {
        for _ in 1...12 {
            displayedCards.append(cardDeck.drawCard()!)
        }
    }
    
    /// Adds 3 more cards to the game if the deck has enough cards.
    mutating func add3MoreCards() {
        if cardDeck.cardsLeft >= 3 {
            for _ in 1...3 {
                displayedCards.append(cardDeck.drawCard()!)
            }
        }
    }
    
}

/// An extension for Int that allows for random number generation with the defined `arc4random` computed property.
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        else {
            return 0
        }
    }
}

