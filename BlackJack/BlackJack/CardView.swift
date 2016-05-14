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
    
    let rowValue : Int = 25
    let columnValue : Int = 125
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)        
    }
    
    init(card : Card,_ cardNumber : Int) {
        self.card = card
        super.init(frame: CGRect(x: 0, y: cardNumber*self.rowValue, width: self.columnValue, height: self.columnValue))
        
        self.refresh(card)
    }
    
    func refresh(card : Card){
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        self.card = card
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.columnValue, height: self.columnValue))
        let labelStr = "\(self.card!.value!) \(self.card!.suit!)"
        label.text = labelStr
        label.font = label.font.fontWithSize(14)
        
        self.addSubview(label)
    }

}
