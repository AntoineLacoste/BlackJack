//
//  Pot.swift
//  BlackJack
//
//  Created by Supinfo on 14/05/16.
//  Copyright © 2016 B3Ingesup. All rights reserved.
//

import Foundation

class Pot{
    
    var tokens : [Token]
    
    var value : Int {
        var value = 0
        for token in self.tokens{
            value += token.tokenColor.rawValue * token.number
        }
        
        return value
    }
    
    var toString : String {
        var str = ""
        for token in self.tokens{
            str += "\(token.tokenColor) : \(token.number) \n"
        }
        
        return str
    }
    
    init(_ blueToken : Int,_ greenToken : Int,_ redToken : Int, _ blackToken : Int){
        self.tokens = [Token]()
        self.tokens.append(Token(.BLUE, number: blueToken))
        self.tokens.append(Token(.GREEN, number: greenToken))
        self.tokens.append(Token(.RED, number: redToken))
        self.tokens.append(Token(.BLACK, number: blackToken))
    }
    
    func minusPot(pot : Pot){
        for index in 0..<pot.tokens.count{
            self.tokens[index].number -= pot.tokens[index].number
        }
    }
    
    func addPot(pot : Pot){
        for index in 0..<pot.tokens.count{
            self.tokens[index].number += pot.tokens[index].number
        }
    }
    
    func divideByTwo() -> Pot{
        var half = Int(self.value / 2)
        
        var nbBlack = 0
        var nbGreen = 0
        var nbRed = 0
        var nbBlue = 0
        
        while tokens[3].tokenColor.rawValue <= half{
            nbBlack += 1
            tokens[3].number -= 1
            half -= tokens[3].tokenColor.rawValue
        }
        
        while tokens[2].tokenColor.rawValue <= half{
            nbRed += 1
            tokens[2].number -= 1
            half -= tokens[2].tokenColor.rawValue
        }
        
        while tokens[1].tokenColor.rawValue <= half{
            nbGreen += 1
            tokens[1].number -= 1
            half -= tokens[1].tokenColor.rawValue
        }
        
        while tokens[0].tokenColor.rawValue <= half{
            nbBlue += 1
            tokens[0].number -= 1
            half -= tokens[0].tokenColor.rawValue
        }
        
        return Pot(nbBlue, nbGreen, nbRed, nbBlack)
    }
    
    func copy() -> Pot{
        let nbBlue  = self.tokens[0].number
        let nbGreen = self.tokens[1].number
        let nbRed   = self.tokens[2].number
        let nbBlack = self.tokens[3].number
        
        return Pot(nbBlue, nbGreen, nbRed, nbBlack)
    }

}