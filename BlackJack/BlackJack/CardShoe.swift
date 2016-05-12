//
//  Shoe.swift
//  BlackJack
//
//  Created by Supinfo on 12/05/16.
//  Copyright © 2016 B3Ingesup. All rights reserved.
//

import Foundation

class CardShoe{
    var cards : [Card]
    
    init(){
        self.cards = [Card]()
        self.cards = self.getAllCards()
        self.shuffleCards()
    }
    
    func getAllCards() -> [Card]{
        var cards = [Card]()
        
        for _ in 1...6{
            for suit in CardSuit.allValues{
                for value in CardValue.allValues{
                    cards.append(Card(value, suit))
                }
            }
        }
        
        return cards
    }
    
    func shuffleCards(){        
        for _ in 0...5000{
            let indexSrc = Int(arc4random_uniform(312))
            let indexDst = Int(arc4random_uniform(312))
            
            let value : Card = self.cards[indexDst]
            self.cards[indexDst] = self.cards[indexSrc]
            self.cards[indexSrc] = value
            
        }
    }    
    
}