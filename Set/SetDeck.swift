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
        for numberOfShape in 1...3 {
            for colorID in 1...3 {
                for shadeID in 1...3 {
                    cards.append(Card(shape: Shape.shape1(numberOfShape: numberOfShape, colorID: colorID, shadeID: shadeID)))
                    cards.append(Card(shape: Shape.shape2(numberOfShape: numberOfShape, colorID: colorID, shadeID: shadeID)))
                    cards.append(Card(shape: Shape.shape3(numberOfShape: numberOfShape, colorID: colorID, shadeID: shadeID)))
                }
            }
        }
    }
    
    mutating func drawCard() -> Card? {
        return cards.count > 0 ? cards.remove(at: cards.count.arc4random) : nil
    }
}
