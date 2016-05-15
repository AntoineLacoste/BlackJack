//
//  CardView.swift
//  BlackJack
//
//  Created by Supinfo on 14/05/16.
//  Copyright © 2016 B3Ingesup. All rights reserved.
//

import UIKit

class BetView: UIView  {
    
    var tokensView : [TokenView]?
    var bet        : Pot?
    
    static let rowValue    : Int = 50
    static let columnValue : Int = 150
    static let marginTop   : Int = {
        return 100 + PlayerView.nameHeight
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(bet : Pot,_ nbCardInHandOverTwo : Int){
        super.init(frame: CGRect(x: 0, y: BetView.marginTop + nbCardInHandOverTwo * CardView.rowValue, width: BetView.columnValue, height: BetView.rowValue))
        self.refresh(bet)
    }
    
    func refresh(bet : Pot){
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        self.tokensView = [TokenView]()
        self.bet = bet
        
        for index in 0..<bet.tokens.count{
            
            let token = self.bet!.tokens[index]
            let tokenView = TokenView(token, index)
            self.tokensView!.append(tokenView)
            
            self.addSubview(tokenView)
        }
        
    }
    
}
