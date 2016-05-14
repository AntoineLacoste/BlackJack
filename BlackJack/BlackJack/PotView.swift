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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(pot : Pot){
        super.init(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        self.tokensView = [TokenView]()
        self.refresh(pot)
    }
    
    func refresh(pot : Pot){        
        self.pot = pot
        
        for index in 0..<pot.tokens.count{
            
            let token = self.pot!.tokens[index]
            let tokenView = TokenView(token, index)
            self.tokensView!.append(tokenView)
            
            self.addSubview(tokenView)
        }
        
    }
    
}
