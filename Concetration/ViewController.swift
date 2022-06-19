//
//  ViewController.swift
//  Concetration
//
//  Created by Алексей Поляков on 07.06.2022.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = Game(numberOfPairOfCards: buttons.count/2)
    var emojiCollection = ["🐨", "🐰", "🐯", "🐒", "🐻", "🦄"]
    
    var touchesCount = 0 {
        didSet {
            touchesLabel.text = "Touches: \(touchesCount)"
        }
    }
    
    var emojiDictionary: [Int:String] = [:]
    
    func getEmoji(for card: Card) -> String {
        if emojiDictionary[card.identifier] == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiCollection.count)))
            emojiDictionary[card.identifier] = emojiCollection.remove(at: randomIndex)
        }
        return emojiDictionary[card.identifier] ?? "?"
    }
    
    func updateUI() {
        for index in buttons.indices {
            let card = game.cards[index]
            let button = buttons[index]
            if card.isFaceUp {
                button.setTitle(getEmoji(for: card), for: .normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? .white : .systemGray2
            }
        }
    }
    
    @IBOutlet weak var touchesLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!
    @IBAction func pressButton(_ sender: UIButton) {
        touchesCount += 1
        if let buttonIndex = buttons.firstIndex(of: sender) {
            game.checkCard(at: buttonIndex)
            updateUI()
        }
    }
}

