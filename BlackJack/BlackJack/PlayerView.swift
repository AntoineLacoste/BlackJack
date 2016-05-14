//
//  CardView.swift
//  BlackJack
//
//  Created by Supinfo on 14/05/16.
//  Copyright © 2016 B3Ingesup. All rights reserved.
//

import UIKit

class PlayerView: UIView  {
    
    var handView : HandView?
    
    var potView : PotView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func refresh(hand : Hand){
        self.refresh(hand, self.potView!.pot!)
        
    }
    
    func refresh(hand : Hand,_ pot : Pot){
        self.handView = HandView(hand: hand)
        self.potView  = PotView(pot: pot)
        
        self.potView!.refresh(pot)
        self.handView!.refresh(hand)
        
        self.addSubview(self.potView!)
        self.addSubview(self.handView!)
    }
    
    func refresh(pot : Pot){
        self.refresh(self.handView!.hand!, pot)
    }
    
}
