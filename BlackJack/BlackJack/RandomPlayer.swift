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
        
        self.tokens.append((color: .BLACK, number: 15))
        self.tokens.append((color: .RED, number: 15))
        self.tokens.append((color: .GREEN, number: 15))
        self.tokens.append((color: .BLUE, number: 15))
    }
    
    override func playTurn(dealerHand: Hand) -> PlayerAction{
        
        if self.hand.containsAS() && self.BJValue > 21 && self.asAsTen{
            self.asAsTen = false
        }
        
        if dealerHand.containsAS(){
            return .INSURANCE
        }
        
        if self.hand.canDouble(){
            return .DOUBLE
        }
        
        if self.hand.BJValue <= 16{
            return .DRAW
        }
        else{
            return .SURRENDER
        }
        return .SEPARATE
    }
    
    override func bet() -> [(color : Token,number : Int)]{
        var bet = [(color : Token,number : Int)]()
        
        var nbBlack = 0
        var nbGreen = 0
        var nbBlue  = 0
        var nbRed   = 0
        
        for token in self.tokens{
            switch(token.color){
                case .BLACK :
                    nbBlack = token.number
                
                case .GREEN :
                    nbGreen = token.number
                
                case .BLUE :
                    nbBlue  = token.number
                
                case .RED :
                    nbRed   = token.number
            }
        }
        
        let tokenBlackBetted = Int(arc4random_uniform(UInt32(nbBlack)))
        let tokenGreenBetted = Int(arc4random_uniform(UInt32(nbGreen)))
        let tokenRedBetted   = Int(arc4random_uniform(UInt32(nbRed)))
        //Bet at least one blue token
        let tokenBlueBetted  = Int(arc4random_uniform(UInt32(nbBlue-1)))+1
        
        bet.append((color: .BLACK, number: tokenBlackBetted))
        bet.append((color: .BLUE, number: tokenBlueBetted))
        bet.append((color: .GREEN, number: tokenGreenBetted))
        bet.append((color: .RED, number: tokenRedBetted))
        
        return bet
    }
    
    override func putBlueCard() -> Int{
        return Int(arc4random_uniform(312))
    }
    
}