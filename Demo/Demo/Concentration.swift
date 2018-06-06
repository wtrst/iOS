//
//  Concentration.swift
//  Demo
//
//  Created by 佐藤亘 on 2018/05/23.
//  Copyright © 2018年 佐藤亘. All rights reserved.
//

import Foundation

class Concentration{
    private(set) var cards = [Card]()
    private var flipCount = 0
    private var score = 0
    
    private var indexOfOneAndOnlyFaceUp: Int? {
        get{
            return cards.indices.filter{ cards[$0].isFaceUp }.oneAndOnly
        }
        
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
//            cards.append(card)
//            cards.append(card)
        }
        
        // shuffle cards
        for i in 0..<cards.count{
            let j = Int(arc4random_uniform(UInt32(cards.indices.last!)))
            if(i != j){
                cards.swapAt(i, j)
            }
        }
    }
    
    func chooseCard(at index: Int) -> [Int] {
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUp, matchIndex != index{
                if cards[index] == cards[matchIndex]{
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                    score += 2
                }
                cards[index].isFaceUp = true
            }
            else{
                indexOfOneAndOnlyFaceUp = index
            }
            if cards[index].hasSeen && !cards[index].isMatched {
                score -= 1
            }
            cards[index].hasSeen = true
        }
        flipCount += 1
        return [flipCount, score]
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
