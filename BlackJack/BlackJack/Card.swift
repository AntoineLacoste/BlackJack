//
//  Card.swift
//  BlackJack
//
//  Created by Supinfo on 12/05/16.
//  Copyright © 2016 B3Ingesup. All rights reserved.
//

import Foundation

class Card{
    var value: CardValue
    
    var suit: CardSuit
    
    var BJValue: Int{
        return self.value.BJValue
    }
    
    init(_ cardValue: CardValue, _ cardSuit: CardSuit){
        self.value = cardValue
        self.suit = cardSuit
    }
}