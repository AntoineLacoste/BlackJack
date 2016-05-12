//
//  CardValue.swift
//  BlackJack
//
//  Created by Supinfo on 12/05/16.
//  Copyright © 2016 B3Ingesup. All rights reserved.
//

import Foundation

enum CardValue: Int{
    case As=1
    case two
    case tree
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    case jack
    case queen
    case king
    
    static let allValues = [As, two, tree, four, five, six, seven, eight, nine, ten, jack, queen, king]
    
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