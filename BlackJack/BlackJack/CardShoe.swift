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
    }
    
    func resetShoe(){
        self.cards = self.resetCards()
        self.shuffleCards()
    }
    
    private func resetCards() -> [Card]{
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
    
    private func shuffleCards(){
        for _ in 0...5000{
            let indexSrc = Int(arc4random_uniform(312))
            let indexDst = Int(arc4random_uniform(312))
            
            let value : Card = self.cards[indexDst]
            self.cards[indexDst] = self.cards[indexSrc]
            self.cards[indexSrc] = value
            
        }
    }
    
    func addBlueCard(blueCardIndex : Int){
        var cards = [Card]()
        
        for index in blueCardIndex...311{
            cards.append(self.cards[index])
        }
        
        for index in 0...blueCardIndex-1{
            cards.append(self.cards[index])
        }
        
        self.cards = cards
    }
    
    func addRedCard(redCardIndex : Int){
        print("red card index : \(redCardIndex)")
        self.cards.insert(Card(nil, nil, true), atIndex: redCardIndex)
    }
    
    func drawCard() -> Card{
        return self.cards.removeFirst()
    }
    
    func burnCards(){
        for _ in 0...4{
            self.cards.removeFirst()
        }
    }
}