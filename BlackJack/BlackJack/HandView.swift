//
//  CardView.swift
//  BlackJack
//
//  Created by Supinfo on 14/05/16.
//  Copyright © 2016 B3Ingesup. All rights reserved.
//

import UIKit

class HandView: UIView  {
    
    var cardsView : [CardView]?
    var hand      : Hand?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(hand : Hand){
        super.init(frame: CGRect(x: 0, y: 45, width: 250, height: 150))
        self.refresh(hand)
    }
    
    func refresh(hand : Hand){
        self.cardsView = [CardView]()
        self.hand     = hand
        
        for index in 0..<self.hand!.cards.count{
            let card = self.hand!.cards[index]
            let cardView = CardView(card: card, index)
            
            self.cardsView!.append(cardView)
            
            self.addSubview(cardView)
        }
    }
    
}
