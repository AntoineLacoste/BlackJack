//
//  CardView.swift
//  BlackJack
//
//  Created by Supinfo on 14/05/16.
//  Copyright © 2016 B3Ingesup. All rights reserved.
//

import UIKit

class PotView: UIView  {
    
    var tokensView : [TokenView]?
    var pot        : Pot?
    
    static let rowValue : Int = 35
    static let columnValue : Int = 250
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(pot : Pot){
        super.init(frame: CGRect(x: 0, y: PlayerView.nameHeight, width: PotView.columnValue, height: PotView.rowValue))
        self.refresh(pot)
    }
    
    func refresh(pot : Pot){
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        self.tokensView = [TokenView]()
        self.pot = pot
        
        for index in 0..<pot.tokens.count{
            
            let token = self.pot!.tokens[index]
            let tokenView = TokenView(token, index)
            self.tokensView!.append(tokenView)
            
            self.addSubview(tokenView)
        }
        
    }
    
}
