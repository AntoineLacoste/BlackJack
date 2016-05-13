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
    
    var tokens : [(color : Token,number : Int)]
    
    var currentBet : [(Token,Int)]
    
    var hand : Hand
    
    var separatedHand : Hand?
    
    var asAsTen : Bool
    
    var BJValue : Int{
        var bjValue = self.hand.BJValue
        if self.asAsTen{
            bjValue += 10
        }
        
        return bjValue
    }
    
    init(nickname : String){
        self.nickname = nickname
        self.tokens = [(color : Token,number : Int)]()
        self.currentBet = [(Token,Int)]()
        self.hand = Hand()
        self.separatedHand = nil
        self.asAsTen = true
    }
    
    func playTurn(dealerHand: Hand) -> PlayerAction{
        fatalError("Method should be implemented")
    }
    
    func bet() -> [(color : Token,number : Int)]{
        fatalError("Method should be implemented")        
    }
    
    func putBlueCard() -> Int{
        fatalError("Method should be implemented")
    }
}