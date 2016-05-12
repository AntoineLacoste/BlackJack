//
//  PLayer.swift
//  BlackJack
//
//  Created by Supinfo on 12/05/16.
//  Copyright © 2016 B3Ingesup. All rights reserved.
//

import Foundation

protocol Player{
    //The player's token stored with type and the number of each type
    var tokens : [(Token,Int)] {get set}
    
    var currentBet : [(Token,Int)] {get set}
    
    var hand : [Card] {get set}
    
    func playTurn(dealerHand: [Card]) -> ()
    
    func bet() -> [(Token,Int)]
    
}
