//
//  CardValue.swift
//  BlackJack
//
//  Created by Supinfo on 12/05/16.
//  Copyright © 2016 B3Ingesup. All rights reserved.
//

import Foundation

enum CardValue: Int{
    case AS=1
    case TWO
    case TREE
    case FOUR
    case FIVE
    case SIX
    case SEVEN
    case EIGHT
    case NINE
    case TEN
    case JACK
    case QUEEN
    case KING
    
    static let allValues = [AS, TWO, TREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, TEN, JACK, QUEEN, KING]
    
    //black jack value
    var BJValue: Int{
        if self.rawValue == 1{
            return 11
        }
        
        if self.rawValue < 11 {
            return self.rawValue
        }
        
        return 10
    }
}