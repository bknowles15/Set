//
//  SetDeck.swift
//  Set
//
//  Created by Bronson Knowles on 5/17/19.
//  Copyright © 2019 Bronson Knowles. All rights reserved.
//

import Foundation

struct SetDeck {
    private var cards = [Card]()
    
    init() {
        for shapeID in 0..<3 {
            for numberOfShape in 1...3 {
                for colorID in 0..<3 {
                    for shadeID in 0..<3 {
                        cards.append(Card(shapeID: shapeID, numberOfShape: numberOfShape, colorID: colorID, shadeID: shadeID))
                    }
                }
            }
        }
    }
    
    mutating func drawCard() -> Card? {
        return cards.count > 0 ? cards.remove(at: cards.count.arc4random) : nil
    }
}
