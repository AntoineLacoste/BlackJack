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
    
    init(_ blueToken : Int,_ redToken : Int,_ greenToken : Int,_ blackToken : Int){
        self.tokens = [Token]()
        self.tokens.append(Token(.BLUE, number: blueToken))
        self.tokens.append(Token(.RED, number: redToken))
        self.tokens.append(Token(.GREEN, number: greenToken))
        self.tokens.append(Token(.BLACK, number: blackToken))
    }
    
    func minusPot(pot : Pot){
        for index in 0..<pot.tokens.count{
            self.tokens[index].number -= pot.tokens[index].number
        }
    }
}