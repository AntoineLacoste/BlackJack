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
    
    static let rowValue : Int = 150
    static let columnValue : Int = 250
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(hand : Hand){
        super.init(frame: CGRect(x: 0, y: PotView.rowValue, width: HandView.columnValue, height: HandView.rowValue))
        self.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        self.refresh(hand)
    }
    
    func refresh(hand : Hand){
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
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
