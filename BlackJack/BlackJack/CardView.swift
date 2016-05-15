//
//  CardView.swift
//  BlackJack
//
//  Created by Supinfo on 14/05/16.
//  Copyright © 2016 B3Ingesup. All rights reserved.
//

import UIKit

class CardView: UIView  {    
    
    var card : Card?
    
    static let rowValue : Int = 25
    static let columnValue : Int = 125
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)        
    }
    
    init(card : Card,_ cardNumber : Int) {
        self.card = card
        super.init(frame: CGRect(x: 0, y: cardNumber * CardView.rowValue, width: CardView.columnValue, height: CardView.columnValue))
        
        self.refresh(card)
    }
    
    func refresh(card : Card){
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        self.card = card
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: CardView.columnValue, height: CardView.columnValue))
        let labelStr = "\(self.card!.value!) \(self.card!.suit!)"
        label.text = labelStr
        label.font = label.font.fontWithSize(14)
        
        self.addSubview(label)
    }

}
