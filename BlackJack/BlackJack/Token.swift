//
//  Token.swift
//  BlackJack
//
//  Created by Supinfo on 14/05/16.
//  Copyright © 2016 B3Ingesup. All rights reserved.
//

import Foundation



class Token{
    
    var tokenColor : TokenColor
    
    var number : Int
    
    init(_ tokenColor : TokenColor, number : Int){
        self.tokenColor = tokenColor
        self.number = number
    }
}