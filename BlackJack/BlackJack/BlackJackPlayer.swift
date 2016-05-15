//
//  BlackJackPlayer.swift
//  BlackJack
//
//  Created by Supinfo on 13/05/16.
//  Copyright © 2016 B3Ingesup. All rights reserved.
//

import Foundation

class BlackJackPlayer{
    var nickname : String
    
    var pot : Pot
    
    var currentBet : Pot
    var hand : Hand
    
    var separatedHand : Hand?
    
    var insurrance : Bool = false
    
    var asAsTen : Bool
    
    var BJValue : Int{
        var bjValue = self.hand.BJValue
        if self.asAsTen{
            bjValue += 10
        }
        
        return bjValue
    }
    
    var stillAlive : Bool = true
    
    init(nickname : String){
        self.nickname = nickname
        self.pot = Pot(15, 15, 15, 15)
        self.currentBet = Pot(0,0,0,0)
        self.hand = Hand()
        self.separatedHand = nil
        self.asAsTen = true
    }
    
    func doubleBet(){
        for index in 0..<self.pot.tokens.count{
            self.currentBet.tokens[index].number = min(self.currentBet.tokens[index].number*2, self.pot.tokens[index].number)
        }
    }
    
    func playTurn(dealerHand: Hand) -> PlayerAction{
        fatalError("Method should be implemented")
    }
    
    func bet(){
        fatalError("Method should be implemented")        
    }
    
    func resetBet(){
        fatalError("Method should be implemented")
    }
        
    func putBlueCard() -> Int{
        fatalError("Method should be implemented")
    }
}