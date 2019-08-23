//
//  ViewController.swift
//  Concentration
//
//  Created by Emma Walker - TVandMobile Platforms - Core Engineering on 02/08/2019.
//  Copyright © 2019 Emma Walker - TVandMobile Platforms - Core Engineering. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    private lazy var game: Concentration =
        Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int{
        return (cardButtons.count+1)/2
    }
    
    private (set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes:[NSAttributedString.Key:Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }

    private (set) var scoreCount = 0 {
        didSet {
            updateScoreCountLabel()
        }
    }
    
    private func updateScoreCountLabel() {
        let attributes:[NSAttributedString.Key:Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Score: \(scoreCount)", attributes: attributes)
        scoreCountLabel.attributedText = attributedString
    }
    
 
    @IBOutlet private weak var scoreCountLabel: UILabel!{
        didSet {
            updateScoreCountLabel()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card not in card buttons")
        }
    }
    
    private func updateViewFromModel(){
        scoreCount = 0
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                                
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
                if card.isMatched{
                    scoreCount += 1
                }
            }
        }
    }
    
    
    private let halloweenTheme = ["👻", "🎃", "🦇" ,"😈", "🤡", "☠️", "🧙‍♀️", "👹"]
    
    private let animalsTheme = ["🦁", "🐸", "🐝" ,"🦋", "🐙", "🦈", "🐻", "🐞"]
    
    private let christmasTheme = ["⛄️", "🥃", "🎄", "🎅🏻", "🎁", "🦌", "⛷", "🦃"]
    
    private let natureTheme = ["🌈", "🌵", "🍄", "🌸", "☀️", "❄️", "🍁", "🐚"]
    
    private let flagsTheme = ["🇮🇪", "🇬🇧", "🇳🇴", "🇨🇭", "🇫🇷", "🇮🇳", "🇪🇸", "🇧🇬"]
    
    private let foodTheme = ["🍏", "🍊", "🍓", "🍋", "🍉", "🍇", "🍍", "🥕"]
    
    private lazy var themes: [[String]] = [halloweenTheme, animalsTheme, christmasTheme, natureTheme, flagsTheme, foodTheme]
    
    private lazy var emojiChoices = themes.randomElement()!
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
  
        if emoji[card] == nil , emojiChoices.count > 0 {
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
            print(emojiChoices)
        }
       
        return emoji[card] ?? "?"
    }
    
    @IBAction private func resetGame(_ sender: UIButton) {
      
        game = Concentration(numberOfPairsOfCards: (cardButtons.count+1)/2)
        flipCount = 0
        scoreCount = 0
        emojiChoices = themes.randomElement()!
        updateViewFromModel()
        
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
