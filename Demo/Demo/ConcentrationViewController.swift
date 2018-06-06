//
//  ViewController.swift
//  Demo
//
//  Created by 佐藤亘 on 2018/05/22.
//  Copyright © 2018年 佐藤亘. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    // MARK: Properties
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int{
        get{
            return cardButtons.count / 2
        }
    }
    
    var theme: [String]? {
        didSet {
            emojiOptions = theme ?? [String]()
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    
    private var emojiOptions = [String]()
    private var emoji = [Card:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseTheme()
    }

    // MARK: Outlet
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var flipCountLabel: UILabel!
    
    // MARK: Methods
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardIndex = cardButtons.index(of: sender){
            var result = self.game.chooseCard(at: cardIndex)
            flipCountLabel.text = "Flips: \(result[0])"
            scoreLabel.text = "Score: \(result[1])"
            updateViewFromModel()
        }
    }
    
    @IBAction func newGameButton(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        chooseTheme()
        emoji = [Card:String]()
        updateViewFromModel()
    }
    
    private func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                
            }
        }
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiOptions.count>0 {
            emoji[card] = emojiOptions.remove(at: emojiOptions.count.arc4random)
        }
        return emoji[card] ?? "?"
    }
    
    private func chooseTheme() {
//        var options: [[String]] = [
//            ["🇯🇵", "🇨🇦", "🇪🇸", "🇧🇷", "🇨🇱", "🇨🇴", "🇨🇲", "🇺🇸", "🇹🇷", "🇬🇧", "🇮🇹", "🇩🇪"],
//            ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🚛", "🚜"],
//            ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏓", "🏸", "🥊", "🥌"],
//            ["🐅", "🐆", "🦓", "🦍", "🐘", "🦏", "🐪", "🦒", "🐃", "🐂", "🐖", "🦌"],
//            ["🙌", "👍", "👎", "👊", "🤞", "✌️", "🤟", "🤘", "☝️", "✋", "🖖", "🤙"],
//            ["👪", "👨‍👩‍👧", "👨‍👩‍👧‍👦", "👨‍👩‍👦‍👦", "👨‍👩‍👧‍👧", "👩‍👩‍👦", "👩‍👩‍👧", "👨‍👨‍👦", "👨‍👨‍👧", "👩‍👦", "👨‍👦", "👨‍👧‍👧"]
//        ]
//        
//        emojiOptions = options[options.count.arc4random]
    }
}
    
extension Int{
    var arc4random: Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        }
        else {
            return 0
        }
    }
}
    
    
    


