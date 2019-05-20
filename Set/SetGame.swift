//
//  SetGame.swift
//  Set
//
//  Created by Bronson Knowles on 5/19/19.
//  Copyright © 2019 Bronson Knowles. All rights reserved.
//
import Foundation

// TODO: Update documentation as struct changes.
/// A game of Set.
/// Keeps track of the displayed cards, selected cards, and score.
struct SetGame {
    private(set) var displayedCards = [Card?]()
    private(set) var selectedCards = Set<Card>()
    private(set) var selectedCardsAreAMatch = false
    private(set) var score = 0
    private var cardDeck = SetDeck()
    private var cardsOnTable: Int
    
    init() {
        for _ in 1...12 {
            displayedCards.append(cardDeck.drawCard()!)
        }
        cardsOnTable = 12
    }
    
    /// Adds 3 more cards to the game if the deck has enough cards.
    mutating func add3MoreCards() {
        if cardDeck.cardsLeft >= 3 {
            // Selected cards form a match
            if selectedCardsAreAMatch {
                replaceSelectedCards()
            }
            else {
                for _ in 1...3 {
                    displayedCards.append(cardDeck.drawCard()!)
                }
                cardsOnTable += 3
            }
        }
    }
    
    /// Marks a card as selected, or deselects a card if there are only 1 or 2 cards already selected.
    mutating func selectCard(at index: Int) {
        if index < displayedCards.count, let card = displayedCards[index] {
            // Previously selected cards match
            if selectedCards.count == 3, !selectedCards.contains(card), selectedCardsAreAMatch {
                replaceSelectedCards()
            }
            // Previously selected cards do not match
            else if selectedCards.count == 3, !selectedCards.contains(card) {
                selectedCards.removeAll()
            }
            // Deselect card
            else if (selectedCards.count == 1 || selectedCards.count == 2), selectedCards.contains(card) {
                selectedCards.remove(card)
                score -= 1
                return
            }
            
            selectedCards.insert(card)
            
            // Detect a match
            if selectedCards.count == 3, selectedCardsMatch() {
                selectedCardsAreAMatch = true
                addToScore()
            }
            else if selectedCards.count == 3 {
                score -= 5
            }
        }
    }
    
    /// Adds points to the user's score for getting a match.
    /// The number of points added depends on the number of cards on the table.
    private mutating func addToScore() {
        if cardsOnTable <= 15 {
            score += 4
        }
        else if cardsOnTable == 18 {
            score += 3
        }
        else if cardsOnTable == 21{
            score += 2
        }
        else if cardsOnTable >= 24 {
            score += 1
        }
    }
    
    /// Replaces cards in `selectedCards` in the case where the selected cards form a set.
    mutating func replaceSelectedCards() {
        for card in selectedCards {
            let index = displayedCards.firstIndex(of: card)!
            if cardDeck.cardsLeft > 0 {
                displayedCards[index] = cardDeck.drawCard()!
            }
            else {
                displayedCards[index] = nil
                cardsOnTable -= 1
            }
            //displayedCards[index] = cardDeck.cardsLeft > 0 ? cardDeck.drawCard()! : nil
        }
        
        selectedCards.removeAll()
        selectedCardsAreAMatch = false
    }
    
    /// Detects whether the 3 currently selected cards form a set.
    func selectedCardsMatch() -> Bool {
        return true // Uncomment to test endgame
        
        // Check shape
        var checkSet = Set<Int>()
        for card in selectedCards {
            checkSet.insert(card.shapeID)
        }
        if checkSet.count == 2 {
            return false
        }
        
        // Check number of shape
        checkSet.removeAll()
        for card in selectedCards {
            checkSet.insert(card.numberOfShape)
        }
        if checkSet.count == 2 {
            return false
        }
        
        // Check color
        checkSet.removeAll()
        for card in selectedCards {
            checkSet.insert(card.colorID)
        }
        if checkSet.count == 2 {
            return false
        }
        
        // Check shade
        checkSet.removeAll()
        for card in selectedCards {
            checkSet.insert(card.shadeID)
        }
        if checkSet.count == 2 {
            return false
        }
        
        return true
    }
    
    /// Returns the indices into `displayedCards` of the cards in `selectedCards`.
    func getSelectedCardIndices() -> Array<Int> {
        var selectedCardIndices = Array<Int>()
        for card in selectedCards {
            let index = displayedCards.firstIndex(of: card)!
            selectedCardIndices.append(index)
        }
        return selectedCardIndices
    }
    
    /// Returns the shade of `card`.
    /// The shade is represented as an Int to be used as a Shade value.
    func getShade(for card: Card) -> Int {
        return card.shadeID
    }
}

/// An extension for Int that allows for random number generation with the defined `arc4random` computed property.
/// Random number is between 0 (inclusive) and `self` (exclusive)
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

