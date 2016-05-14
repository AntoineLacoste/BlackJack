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
    
    init(_ blueToken : Int,_ redToken : Int,_ greenToken : Int,_ blackToken : Int){
        self.tokens = [Token]()
        self.tokens.append(Token(.BLUE, number: blueToken))
        self.tokens.append(Token(.RED, number: redToken))
        self.tokens.append(Token(.GREEN, number: greenToken))
        self.tokens.append(Token(.BLACK, number: blackToken))
    }
}