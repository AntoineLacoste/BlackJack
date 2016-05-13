//
//  Dealer.swift
//  BlackJack
//
//  Created by Supinfo on 12/05/16.
//  Copyright © 2016 B3Ingesup. All rights reserved.
//

import Foundation

class Dealer{
    
    var players : [BlackJackPlayer]
    
    var currentPlayer : Int
    
    var hand : Hand
    
    var cardShoe : CardShoe
    
    var resetShoeOnThisTurn : Bool
    
    init(){
        self.players = [BlackJackPlayer]()
        self.hand = Hand()
        self.cardShoe = CardShoe()
        self.currentPlayer = 0
        self.resetShoeOnThisTurn = true
    }
    
    func addPlayer(player : BlackJackPlayer){
        self.players.append(player)
    }
    
    func shuffleShoe(){        
        self.cardShoe = CardShoe()
        self.cardShoe.resetCards()
        
        self.putBlueCard()
        self.addRedCard()
        
    }
    
    func putBlueCard(){
        let blueCardIndex = self.players[Int(arc4random_uniform(4))].putBlueCard()
        self.cardShoe.addBlueCard(blueCardIndex)
    }
    
    func addRedCard(){
        self.cardShoe.addRedCard(Int(arc4random_uniform(306))+6)
    }
    
    func startGame(){
        self.startTurn()
    }
    
    func startTurn(){
        if self.resetShoeOnThisTurn{
            self.cardShoe.resetShoe()
            self.cardShoe.burnCards()
            self.dealStartCards()
            self.resetShoeOnThisTurn = false
        }
    }
    
    func dealStartCards(){
        for player in self.players{
            let card = self.cardShoe.drawCard()
            if card.isRed{
                self.resetShoeOnThisTurn = true
            }
            player.hand.addCard(card)
        }
        
        var card = self.cardShoe.drawCard()
        if card.isRed{
            self.resetShoeOnThisTurn = true
        }
        self.hand.addCard(self.cardShoe.drawCard())
        
        for player in self.players{
            let card = self.cardShoe.drawCard()
            if card.isRed{
                self.resetShoeOnThisTurn = true
            }
            player.hand.addCard(card)
        }
        
        card = self.cardShoe.drawCard()
        if card.isRed{
            self.resetShoeOnThisTurn = true
        }
        self.hand.addCard(self.cardShoe.drawCard())
        
    }
    
}