//
//  Card.swift
//  Set
//
//  Created by Bronson Knowles on 5/17/19.
//  Copyright © 2019 Bronson Knowles. All rights reserved.
//

import Foundation

/// A Set card.
/// Keeps track of the identifier for the card's shape, color, and shade, as well as the number of times
/// the shape appears on the card.
struct Card {
    let shapeID: Int
    let numberOfShape: Int
    let colorID: Int
    let shadeID: Int
}
