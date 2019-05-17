//
//  Card.swift
//  Set
//
//  Created by Bronson Knowles on 5/17/19.
//  Copyright © 2019 Bronson Knowles. All rights reserved.
//

import Foundation

struct Card {
    let shape: Shape
}

enum Shape: Hashable {
    case shape1(numberOfShape: Int, colorID: Int, shadeID: Int)
    case shape2(numberOfShape: Int, colorID: Int, shadeID: Int)
    case shape3(numberOfShape: Int, colorID: Int, shadeID: Int)
    
    func toInt() -> Int {
        switch self {
        case .shape1: return 1
        case .shape2: return 2
        case .shape3: return 3
        }
    }
    
    var hashValue: Int {
        return self.toInt()
    }
}
