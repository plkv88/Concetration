//
//  ViewController.swift
//  Concetration
//
//  Created by Алексей Поляков on 07.06.2022.
//

import UIKit

class ViewController: UIViewController {

    private lazy var game = Game(numberOfPairOfCards: numberOfPairOfCards)
    
    var numberOfPairOfCards: Int {
        return (buttons.count+1)/2
    }
    
    private(set) var touchesCount = 0 {
        didSet {
            touchesLabel.text = "Touches: \(touchesCount)"
        }
    }
    
    private var emojiCollection = ["🐨", "🐰", "🐯", "🐒", "🐻", "🦄"]
    private var emojiDictionary: [Card:String] = [:]
    
    private func getEmoji(for card: Card) -> String {
        if emojiDictionary[card] == nil {
            emojiDictionary[card] = emojiCollection.remove(at: emojiCollection.count.random)
        }
        return emojiDictionary[card] ?? "?"
    }
    
    private func updateUI() {
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
    
    @IBOutlet private weak var touchesLabel: UILabel!
    @IBOutlet private var buttons: [UIButton]!
    @IBAction private func pressButton(_ sender: UIButton) {
        touchesCount += 1
        if let buttonIndex = buttons.firstIndex(of: sender) {
            game.checkCard(at: buttonIndex)
            updateUI()
        }
    }
}

extension Int {
    var random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

