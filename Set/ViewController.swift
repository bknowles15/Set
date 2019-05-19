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
            cardButtons[index].backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            let card = game.displayedCards[index]
            let cardShape = Shape.getShape(for: card)
            let cardString = cardShape * card.numberOfShape
            let attributes: [NSAttributedString.Key: Any] = [
                .strokeWidth: 5.0,
                .strokeColor: Color.getColor(for: card)
            ]
            let cardAttributedText = NSAttributedString(string: cardString, attributes: attributes)
            cardButtons[index].setAttributedTitle(cardAttributedText, for: UIControl.State.normal)
        }
    }
    
    /// Stores a game of Set, including the displayed cards, selected cards, and status of the game.
    lazy private var game = Set()
    
    /// Outlets for the buttons and labels on screen.
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var newGameButton: UIButton!
    @IBOutlet private var cardButtons: [UIButton]!
    
    /// Selects a card when the chosen card is touched.
    @IBAction func touchCard(_ sender: UIButton) {
        let cardIndex = cardButtons.firstIndex(of: sender)!
        if cardIndex < game.displayedCards.count {
            sender.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            sender.layer.borderWidth = 3.0
            sender.layer.borderColor = UIColor.blue.cgColor
        }
    }
    
    /// Creates a new game when `newGameButton` is pressed.
    @IBAction private func touchNewGameButton(_ sender: UIButton) {
        // Create a new game
    }
    
    private var numberOfDrawnCards = 12
    
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

/// Overload of the * operator for strings to repeat a given string `lhs` by `rhs` times.
/// Similar to the * operator for strings in Python.
func *(lhs: String, rhs: Int) -> String {
    var repeatedString = ""
    for _ in 0..<rhs {
        repeatedString += lhs
    }
    return repeatedString
}
