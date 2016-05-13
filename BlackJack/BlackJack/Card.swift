//
//  Card.swift
//  BlackJack
//
//  Created by Supinfo on 12/05/16.
//  Copyright © 2016 B3Ingesup. All rights reserved.
//

import Foundation

class Card {
    var value: CardValue?
    
    var suit: CardSuit?
    
    var isRed : Bool
    
    var BJValue: Int{
        return self.value!.BJValue
    }
    
    convenience init(_ cardValue: CardValue, _ cardSuit: CardSuit){
        self.init(cardValue, cardSuit, false)
    }
    
    convenience init(isRed : Bool){
        self.init(nil, nil, false)
    }
    
    init(_ cardValue: CardValue?, _ cardSuit: CardSuit?, _ isRed : Bool){
        self.value = cardValue
        self.suit  = cardSuit
        self.isRed = isRed
    }
}