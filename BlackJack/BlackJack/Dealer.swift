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
    
    var BJValue : Int{
        var bjValue = self.hand.BJValue
        
        if self.hand.containsAS() && self.hand.BJValue < 12{
            bjValue += 10
        }
        
        return bjValue
    }
    
    
    var BlackJack : Bool{
        if self.BJValue == 21 && self.hand.cards.count == 2{
            return true
        }
        
        return false
    }
    
    var currentBJPlayer : BlackJackPlayer{
        return self.players[self.currentPlayer]
    }
    
    var realPlayer : BlackJackPlayer{
        return self.players[0]
    }
    
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
        self.cardShoe.resetShoe()
        
        self.putBlueCard()
        self.addRedCard()
        
    }
    
    func putBlueCard(){
        let blueCardIndex = Int(arc4random_uniform(312))
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
            self.shuffleShoe()
            self.cardShoe.burnCards()
            self.dealStartCards()
            self.resetShoeOnThisTurn = false
        }
        else{
            self.dealStartCards()
        }
    }
    
    func dealStartCards(){
        for player in self.players{
            self.draw(player)
        }
        
        self.hand.addCard(self.drawCard())
        
        for player in self.players{
            self.draw(player)
        }
        
        self.hand.addCard(self.drawCard())
        
    }
    
    func drawCard() -> Card{
        var card = self.cardShoe.drawCard()
        
        if card.isRed{
            self.resetShoeOnThisTurn = true
            card = self.cardShoe.drawCard()
        }
        
        return card
    }
    
    func nextPlayer(){
        self.currentPlayer = (self.currentPlayer + 1) % 4
    }
    
    func playerSurrender(player : BlackJackPlayer){
        player.stillAlive = false
        player.pot.addPot(player.currentBet.divideByTwo())
        self.resolveTurn()
        self.restartTurn()
    }
    
    func playerInsurrance(player : BlackJackPlayer){
        player.insurrance = true
    }
    
    func playerDouble(player : BlackJackPlayer){
        player.doubleBet()
        self.draw(player)
    }
    
    func playerStand(player : BlackJackPlayer){
        if player.standForMainHand{
            player.standForSeparatedHand = true
            self.currentPlayer += 1
        }
        else{
            player.standForMainHand = true
            if player.separatedHand == nil {
                self.currentPlayer += 1
            }
        }
    }
    
    func playerSeparate(player : BlackJackPlayer){
        player.separateHand()
    }
    
    func randomPlayTurn(){
        for index in 1..<4{
            let player = self.players[index]
            var action = self.players[index].playTurn(self.hand)
            while action != .STAND{
                switch action{
                case .INSURANCE:
                    self.playerInsurrance(player)
                    action = self.players[index].playTurn(self.hand)
                case .DOUBLE:
                    self.playerDouble(player)
                    action = self.players[index].playTurn(self.hand)
                default:
                    self.draw(player)
                    print("bjvalue player \(index) : \(player.hand.BJValue)")
                    if player.hand.BJValue > 21{
                        action = PlayerAction.STAND
                    }
                    else{
                        action = self.players[index].playTurn(self.hand)
                    }
                }
            }
        }
        
        while self.BJValue <= 16 {
            self.hand.addCard(self.drawCard())
        }
        
        self.resolveTurn()
    }
    
    func resolveTurn(){

        var alreadyResolved = false
        var totalEarned = 0
        
        if self.BJValue > 21 {
            for index in 0..<self.players.count{
                
                let player = self.players[index]
                
                if index == 0 {
                    totalEarned += player.currentBet.value * 2
                }
                
                player.pot.addPot(player.currentBet)
                player.pot.addPot(player.currentBet)
            }
            alreadyResolved = true
        }
        
        if self.BlackJack{
            for index in 0..<self.players.count{
                let player = self.players[index]
                
                if player.stillAlive{
                    if player.BlackJackMain{
                        player.pot.addPot(player.currentBet)
                        
                        if index == 0 {
                            totalEarned += player.currentBet.value
                        }
                    }
                    else{
                        if player.insurrance{
                            player.pot.addPot(player.currentBet)
                            player.pot.addPot(player.currentBet)
                            
                            if index == 0 {
                                totalEarned += player.currentBet.value * 2
                            }
                        }
                    }
                }
            }
            alreadyResolved = false
        }
        
        if !alreadyResolved{
            for index in 0..<self.players.count{
                let player = self.players[index]
                
                if player.stillAlive{
                    
                    if player.BlackJackMain{
                        player.pot.addPot(player.currentBet)
                        player.pot.addPot(player.currentBet)
                        player.pot.addPot(player.currentBet.divideByTwo())
                        totalEarned += Int(Double(player.currentBet.value) * 2.5)
                    }
                    else{
                        if player.BJValue > self.BJValue{
                            player.pot.addPot(player.currentBet)
                            player.pot.addPot(player.currentBet)
                            
                            if index == 0 {
                                totalEarned += player.currentBet.value * 2
                            }
                        }
                        
                        if player.BJValue == self.BJValue{
                            player.pot.addPot(player.currentBet)
                            if index == 0 {
                                totalEarned += player.currentBet.value
                            }
                        }
                    }
                }
            }
        }
        
        if self.realPlayer.separatedHand != nil {
            let player = self.realPlayer
            
            if player.stillAlive{
                if self.BJValue > 21 {
                    player.pot.addPot(player.currentBet)
                    player.pot.addPot(player.currentBet)
                    
                    totalEarned += player.currentBet.value * 2
                }
            
                if self.BlackJack{
                    if player.BlackJackMain{
                        player.pot.addPot(player.currentBet)
                        
                        totalEarned += player.currentBet.value
                    }
                    else{
                        if player.insurrance{
                            player.pot.addPot(player.currentBet)
                            player.pot.addPot(player.currentBet)
                            
                            totalEarned += player.currentBet.value * 2
                        }
                    }
                
                }
            
                if player.BJValue > self.BJValue{
                    player.pot.addPot(player.currentBet)
                    player.pot.addPot(player.currentBet)
                    
                    totalEarned += player.currentBet.value * 2
                }
                
                if player.BJValue == self.BJValue{
                    player.pot.addPot(player.currentBet)
                    
                    totalEarned += player.currentBet.value
                }
            }

        }
        
        var str = ""
        
        if totalEarned == 0 {
            str = "You lost"
        }
        else{
            str = "You earned : \(totalEarned)"
        }
        
        let myDict = [ "str": str]
        
        //NSNotificationCenter.defaultCenter().postNotificationName("displayEndTurn", object: str)
        NSNotificationCenter.defaultCenter().postNotificationName("displayEndTurn", object: myDict)
    }
    
    func randomBet(){
        for index in 1..<4{
            self.players[index].bet()
        }
    }
    
    func restartTurn(){
        for player in self.players{
            player.asAsEleven = true
            player.asAsElevenSepHand = true
            player.hand = Hand()
            player.separatedHand = nil
            player.standForMainHand = false
            player.standForSeparatedHand = false
            player.stillAlive = true
            player.insurrance = false
            player.resetBet()
        }
        self.hand = Hand()
        self.startTurn()
    }
    
    func draw(playerIndex : Int){
        if self.currentBJPlayer.separatedHand != nil && self.currentBJPlayer.standForMainHand{
            self.players[playerIndex].separatedHand!.addCard(self.drawCard())
        }
        else{
            self.players[playerIndex].hand.addCard(self.drawCard())
        }
        //real player just drew
        if self.currentPlayer == 0{
            if self.currentBJPlayer.hand.containsAS(){
                if self.currentBJPlayer.hand.haveChoiceForAs(){
                    NSNotificationCenter.defaultCenter().postNotificationName("displayAsChoice", object: nil)                    
                }
            }
            
            if self.currentBJPlayer.BJValue > 21{
                NSNotificationCenter.defaultCenter().postNotificationName("burn", object: nil)
            }
            
        }
    }
    
    func draw(player : BlackJackPlayer){
        if self.currentBJPlayer.separatedHand != nil && self.currentBJPlayer.standForMainHand{
            player.separatedHand!.addCard(self.drawCard())
        }
        else{
            player.hand.addCard(self.drawCard())
        }
        //real player just drew
        if self.currentPlayer == 0{
            if self.currentBJPlayer.hand.containsAS(){
                if self.currentBJPlayer.hand.haveChoiceForAs(){
                    NSNotificationCenter.defaultCenter().postNotificationName("displayAsChoice", object: nil)
                }
            }
            
            if self.currentBJPlayer.BJValue > 21{
                NSNotificationCenter.defaultCenter().postNotificationName("burn", object: nil)
            }
            
        }
    }
    
}