//
//  PlayingCard.swift
//  DemoPlayingCard
//
//  Created by 佐藤亘 on 2018/05/28.
//  Copyright © 2018年 佐藤亘. All rights reserved.
//

import Foundation

struct PlayingCard: CustomStringConvertible{
    var description: String {
        return "\(rank)\(suit)"
    }
    
    
    var suit: Suit
    var rank: Rank


    enum Suit: Strin, CustomStringConvertible{
        var description: String{
            return "\(rawValue)"
        }
        
        case hearts = "♥️"
        case diamonds = "♦️"
        case clubs = "♣️"
        case spades = "♠️"
        
        static var all = [Suit.hearts,.diamonds,.clubs,.spades]
    }
    
    enum Rank: CustomStringConvertible {
        var description: String {
            switch self {
            case .ace: return "A"
            case .numeric(let pips): return String(pips)
            case .face(let kind): return kind
            }
        }
        
        case ace
        case numeric(Int)
        case face(String)
        
        var order: Int {
            switch self {
            case .ace: return 1
            case .numeric(let pips): return pips
            case .face(let kind) where kind == "J": return 11
            case .face(let kind) where kind == "Q": return 12
            case .face(let kind) where kind == "K": return 13
            default: return 0
            }
        }
        
        static var all: [Rank]{
            var allRanks = [Rank.ace]
            for pips in 2...10 {
                allRanks.append(Rank.nunmeric(pips))
            }
            allRanks += [Rank.face("J"),.face("Q"),.face("K")]
            return allRanks
        }
    }
}
