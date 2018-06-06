//
//  Card.swift
//  Demo
//
//  Created by 佐藤亘 on 2018/05/23.
//  Copyright © 2018年 佐藤亘. All rights reserved.
//

import Foundation

struct Card: Hashable{
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    var hasSeen = false
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
    
    // MARK: Hashable protocol
    var hashValue: Int{
        return identifier
    }
    
    //MARK
    static func == (lhs: Card, rhs: Card) -> Bool{
        return lhs.identifier == rhs.identifier
    }
}
