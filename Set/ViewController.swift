//
//  ViewController.swift
//  Set
//
//  Created by Bronson Knowles on 5/16/19.
//  Copyright © 2019 Bronson Knowles. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set corners of buttons to be rounded.
        for index in cardButtons.indices {
            cardButtons[index].layer.cornerRadius = 8.0
        }
        
        // Display the first 12 cards.
        for index in game.displayedCards.indices {
            displayCard(at: index)
        }
    }
    
    /// Displays a Set card by making the background white and adding the appropriate image.
    private func displayCard(at index: Int) {
        // Card is still in play
        if let card = game.displayedCards[index] {
            cardButtons[index].backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cardButtons[index].layer.borderWidth = 0.0
            
            let cardShape = Shape.getShape(for: card)
            let cardColor = Color.getColor(for: card)
            let cardShade = game.getShade(for: card)
            let cardString = cardShape * card.numberOfShape
            let attributes = getStringAttributes(color: cardColor, shade: cardShade)
            let cardAttributedText = NSAttributedString(string: cardString, attributes: attributes)
            
            cardButtons[index].setAttributedTitle(cardAttributedText, for: UIControl.State.normal)
        }
        
        // No cards left to show; make card invisible.
        else {
            makeCardInvisible(at: index)
        }
    }
    
    /// Makes a card invisible when there is no card to be displayed, or when game has restarted.
    private func makeCardInvisible(at index: Int) {
        cardButtons[index].backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        cardButtons[index].layer.borderWidth = 0.0
        
        let attributes = [NSAttributedString.Key: Any]()
        let cardAttributedText = NSAttributedString(string: "", attributes: attributes)
        
        cardButtons[index].setAttributedTitle(cardAttributedText, for: UIControl.State.normal)
    }
    
    /// Stores a game of Set, including the displayed cards, selected cards, and status of the game.
    lazy private var game = SetGame()
    
    /// Outlets for the buttons and labels on screen.
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var newGameButton: UIButton!
    @IBOutlet private var cardButtons: [UIButton]!
    
    /// Selects a card when the chosen card is touched.
    @IBAction func touchCard(_ sender: UIButton) {
        let cardIndex = cardButtons.firstIndex(of: sender)!
        game.selectCard(at: cardIndex)
        updateView()
    }
    
    /// Displays 3 more cards when the "Deal 3 More Cards" button is pressed.
    @IBAction func touchDeal3MoreCardsButton(_ sender: Any) {
        // Replace matched cards.
        if game.selectedCardsAreAMatch {
            game.add3MoreCards()
        }
        // There is enough room on the UI to add more cards.
        else if numberOfDisplayedCards < maxNumberOfCards {
            game.add3MoreCards()
            numberOfDisplayedCards += 3
        }
        
        updateView()
    }
    /// Creates a new game when `newGameButton` is pressed.
    @IBAction private func touchNewGameButton(_ sender: UIButton) {
        game = SetGame()
        numberOfDisplayedCards = 12
        removeNewlyUndisplayedCards()
        updateView()
    }
    
    private let maxNumberOfCards = 24
    private var numberOfDisplayedCards = 12
    
    /// Updates the view after making a change to the game.
    private func updateView() {
        for index in game.displayedCards.indices {
            displayCard(at: index)
        }
        
        for index in game.getSelectedCardIndices() {
            cardButtons[index].layer.borderWidth = 3.0
            cardButtons[index].layer.borderColor = UIColor.blue.cgColor
        }
        
        if game.selectedCards.count == 3 {
            for index in game.getSelectedCardIndices() {
                cardButtons[index].backgroundColor = game.selectedCardsAreAMatch ? #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1) : #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
            }
        }
        
        scoreLabel.text = "Score: \(game.score)"
    }
    
    /// Removes the cards that are not supposed to be displayed anymore because a new game has started.
    private func removeNewlyUndisplayedCards() {
        for index in stride(from: game.displayedCards.count, to: maxNumberOfCards, by: 1) {
            makeCardInvisible(at: index)
        }
    }
    
    /// Sets the attributes for an NSAttributedString based on the provided color and shade values.
    func getStringAttributes(color: UIColor, shade shadeValue: Int) -> [NSAttributedString.Key: Any] {
        var attributes: [NSAttributedString.Key: Any] = [
            .strokeColor: color
        ]
        
        let shade = Shade(rawValue: shadeValue)!
        switch shade {
        case .filled:
            attributes[.strokeWidth] = -5.0
            attributes[.foregroundColor] = color
        case .striped:
            attributes[.strokeWidth] = -5.0
            attributes[.foregroundColor] = color.withAlphaComponent(0.15)
        case .outline:
            attributes[.strokeWidth] = 5.0
        }
        
        return attributes
    }
    
}

/// Stores the different shape choices for a card.
enum Shape: String {
    case triangle = "▲"
    case square = "■"
    case circle = "●"
    
    static var all = [Shape.triangle, .square, .circle]
    
    static func getShape(for card: Card) -> String {
        return Shape.all[card.shapeID].rawValue
    }
}

/// Stores the different color choices for a card.
enum Color {
    case red, green, blue
    
    static func getColor(for card: Card) -> UIColor {
        let colorValue = Color.all[card.colorID]
        switch colorValue {
        case .red: return #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        case .green: return #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        case .blue: return #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        }
    }
    
    static var all = [Color.red, .green, .blue]
}

/// Stores the different shade choices for a card.
enum Shade: Int {
    case filled, striped, outline
}

/// Overload of the * operator for strings to repeat a given string `lhs` by `rhs` times.
/// Similar to the * operator for strings in Python.
func *(lhs: String, rhs: Int) -> String {
    var repeatedString = ""
    for _ in 0..<rhs {
        repeatedString += lhs
    }
    return repeatedString
}
