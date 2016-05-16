//
//  Hand.swift
//  BlackJack
//
//  Created by Supinfo on 13/05/16.
//  Copyright © 2016 B3Ingesup. All rights reserved.
//

import Foundation

class Hand{
    var cards : [Card]
    
    var BJValue : Int{
        var val = 0
        for card in self.cards{
            val += card.BJValue
        }
        return val
    }

    init(){
        self.cards = [Card]()
    }
    
    func addCard(card : Card){
        self.cards.append(card)
    }
    
    func containsAS() -> Bool{
        for card in self.cards{
            if card.value!.rawValue == 1{
                return true
            }
        }
        
        return false
    }
    
    func haveChoiceForAs() -> Bool{
        if self.BJValue < 12{
            return true
        }
        
        return false
    }
    
    func canDouble() -> Bool{
        if self.BJValue <= 9 && self.BJValue >= 11 && self.cards.count == 2{
            return true
        }
        
        return false        
    }
    
    func canSeparate() -> Bool{
        if self.cards.count == 2 && self.cards[0].value == self.cards[1].value{
            return true
        }
        
        return false
    }
}