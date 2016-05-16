//
//  CardSuit.swift
//  BlackJack
//
//  Created by Supinfo on 12/05/16.
//  Copyright © 2016 B3Ingesup. All rights reserved.
//

import Foundation

enum CardSuit : Int{
    case SPADES=1
    case HEARTS
    case DIAMONDS
    case CLUBS
    
    static let allValues = [SPADES, HEARTS, DIAMONDS, CLUBS]
    
    var toUnicode : Int{
        switch self.rawValue{
            case 1:
                return 2660
            case 2:
                return 2665
            case 3:
                return 2666
            default:
                return 2663
        }
    }
}