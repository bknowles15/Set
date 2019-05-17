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
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var newGameButton: UIButton!
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        ]
        let cardAttributedText = NSAttributedString(string: "▲▲▲", attributes: attributes)
        sender.setAttributedTitle(cardAttributedText, for: UIControl.State.normal)
    }
    
    @IBAction private func touchNewGameButton(_ sender: UIButton) {
    }
    
    private var numberOfDrawnCards = 12
    
    //lazy private var game = Set()
    
    
    
}

