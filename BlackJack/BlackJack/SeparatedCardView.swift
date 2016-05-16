//
//  CardView.swift
//  BlackJack
//
//  Created by Supinfo on 14/05/16.
//  Copyright © 2016 B3Ingesup. All rights reserved.
//

import UIKit

class SeparatedCardView: UIView  {
    
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
        var labelStr = "\(self.card!.value!) "
        switch self.card!.suit!.toUnicode{
        case 2660 :
            labelStr += "\u{2660}"
        case 2665:
            labelStr += "\u{2665}"
        case 2666:
            labelStr += "\u{2666}"
        default:
            labelStr += "\u{2663}"
        }
        label.text = labelStr
        label.font = label.font.fontWithSize(13)
        
        self.addSubview(label)
    }
    
}
