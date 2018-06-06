//
//  PlayingCardDeck.swift
//  DemoPlayingCard
//
//  Created by 佐藤亘 on 2018/05/28.
//  Copyright © 2018年 佐藤亘. All rights reserved.
//

import Foundation

struct PlayingCardDeck {
    private(set) var cards = [PlayingCard]()
    
    init() {
        for suit in PlayingCard.Suit.all {
            for rank in PlayingCard.Rank.all{
                cards.append(PlayingCard(suit: suit, rank: rank))
            }
        }
    }
    
    mutating func printCards() -> PlayingCard? {
        return cards.count > 0 ? cards.remove(at: cards.count.arc4random) : nil
    }
}

extension Int {
    var arc4random: Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        else{
            
        }
        
    }
}
