//
//  RandomPlayer.swift
//  BlackJack
//
//  Created by Supinfo on 13/05/16.
//  Copyright © 2016 B3Ingesup. All rights reserved.
//

import Foundation

class RandomPlayer : BlackJackPlayer{
    
    override init(nickname : String){
        super.init(nickname: nickname)
    }
    
    override func playTurn(dealerHand: Hand) -> PlayerAction{
        
        if self.hand.containsAS() && self.BJValue > 21 && self.asAsTen{
            self.asAsTen = false
        }
        
        if dealerHand.containsAS(){
            return .INSURANCE
        }
        
        if self.hand.canSeparate(){
            return .SEPARATE
        }
        
        if self.hand.canDouble(){
            return .DOUBLE
        }
        
        if self.hand.BJValue <= 16{
            return .DRAW
        }
        else{
            return .STAND
        }
    }
    
    override func bet(){
        var nbBlack = 0
        var nbGreen = 0
        var nbBlue  = 0
        var nbRed   = 0
        
        for token in self.pot.tokens{
            switch(token.tokenColor){
                case .BLACK :
                    nbBlack = token.number
                
                case .GREEN :
                    nbGreen = token.number
                
                case .BLUE  :
                    nbBlue  = token.number
                
                case .RED   :
                    nbRed   = token.number
            }
        }
        
        let tokenBlackBetted = Int(arc4random_uniform(UInt32(nbBlack)))
        let tokenGreenBetted = Int(arc4random_uniform(UInt32(nbGreen)))
        let tokenRedBetted   = Int(arc4random_uniform(UInt32(nbRed)))
        //Bet at least one blue token
        let tokenBlueBetted  = Int(arc4random_uniform(UInt32(nbBlue-1)))+1
        
        let bet = Pot(tokenBlueBetted, tokenRedBetted, tokenGreenBetted, tokenBlackBetted)
        self.pot.minusPot(bet)
        self.currentBet = bet
    }
    
    override func putBlueCard() -> Int{
        return Int(arc4random_uniform(312))
    }
    
    override func resetBet() {
        self.currentBet = Pot(0,0,0,0)
    }
    
}