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
    
    var pot : Pot = Pot(15, 15, 15, 15)
    
    var currentBet : Pot = Pot(0,0,0,0)
    
    var hand : Hand = Hand()
    
    var separatedHand : Hand? = nil
    
    var insurrance : Bool = false
    
    var asAsEleven : Bool = true
    
    var asAsElevenSepHand : Bool = true
    
    var standForMainHand : Bool = false
    
    var standForSeparatedHand : Bool = false
    
    var BlackJackMain : Bool{
        if self.BJValue == 21 && self.hand.cards.count == 2{
            return true
        }
        
        return false
    }
    
    var BlackJackSep : Bool{
        if separatedHand != nil{
            if self.BJValue == 21 && self.separatedHand!.cards.count == 2{
                return true
            }
        }
        
        return false
    }
    
    var BJValue : Int{
        var bjValue : Int

        bjValue = self.hand.BJValue
        
        if self.asAsEleven && self.hand.containsAS(){
            bjValue += 10
        }        
        
        return bjValue
    }
    
    var BJValueSeparated : Int{
        var bjValue : Int = 0
        
        if self.separatedHand != nil{
            bjValue = self.separatedHand!.BJValue
            
            if self.asAsElevenSepHand && self.separatedHand!.containsAS(){
                bjValue += 10
            }
        }
        
        return bjValue
    }
    
    var stillAlive : Bool = true
    
    init(nickname : String){
        self.nickname = nickname
    }
    
    func doubleBet(){
        let potDoubled = self.numberToBet(self.currentBet.value)
        
        self.currentBet.addPot(potDoubled!)
    }
    
    func numberToBet(var bet : Int) -> Pot?{
        let pot = self.pot.copy()
        
        let tokens = pot.tokens
        
        var nbBlack = 0
        var nbGreen = 0
        var nbRed = 0
        var nbBlue = 0
        
        while tokens[3].number > 0 && tokens[3].tokenColor.rawValue <= bet{
            nbBlack += 1
            tokens[3].number -= 1
            bet -= tokens[3].tokenColor.rawValue
        }
        
        while tokens[2].number > 0 && tokens[2].tokenColor.rawValue <= bet{
            nbRed += 1
            tokens[2].number -= 1
            bet -= tokens[2].tokenColor.rawValue
        }
        
        while tokens[1].number > 0 && tokens[1].tokenColor.rawValue <= bet{
            nbGreen += 1
            tokens[1].number -= 1
            bet -= tokens[1].tokenColor.rawValue
        }
        
        while tokens[0].number > 0 && tokens[0].tokenColor.rawValue <= bet{
            nbBlue += 1
            tokens[0].number -= 1
            bet -= tokens[0].tokenColor.rawValue
        }
        
        if bet != 0{
            return nil
        }
        
        return Pot(nbBlue, nbGreen, nbRed, nbBlack)
    }
    
    func canDouble() -> Bool{
        if self.handForDouble() && self.separatedHand == nil{
            if let _ = self.numberToBet(self.currentBet.value){
                return true
            }
        }
        
        return false
    }
    
    func handForDouble() -> Bool{
        if self.BJValue >= 9 && self.BJValue <= 11 && self.hand.cards.count == 2{
            return true
        }
        return false
    }
    
    func valueWithAsAsEleven() -> Int{
        
        if self.separatedHand != nil && self.standForMainHand{
            
            if !self.separatedHand!.containsAS(){
                return self.separatedHand!.BJValue
            }
        
        return self.separatedHand!.BJValue + 10
        }
        else{
            if !self.hand.containsAS(){
                return self.hand.BJValue
            }
        }
        
        return self.hand.BJValue + 10
    }
    
    func valueWithAsAsOne() -> Int{
        return self.hand.BJValue
    }
    
    func nothingToDo() -> Bool{
        if self.separatedHand  == nil{
            if self.standForMainHand{
                return true
            }
            return false
        }
        
        if self.standForSeparatedHand{
            return true
        }
        return false
    }
    
    func separateHand(){
        let card = self.hand.cards.removeLast()
        self.separatedHand = Hand()
        self.separatedHand!.addCard(card)
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