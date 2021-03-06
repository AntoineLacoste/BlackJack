//
//  CardView.swift
//  BlackJack
//
//  Created by Supinfo on 14/05/16.
//  Copyright © 2016 B3Ingesup. All rights reserved.
//

import UIKit

class TokenView: UIView  {
    
    var token : Token?
    
    static let rowValue : Int = 25
    static let columnValue : Int = 75
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(_ token : Token,_ tokenNumber : Int) {
        
        self.token  = token
        
        var row : Int
        
        if tokenNumber > 1{
            row = 1
        }
        else{
            row = 0
        }
        
        var column : Int
        
        if tokenNumber % 2 == 0{
            column = 0
        }
        else{
            column = 1
        }
        
        super.init(frame: CGRect(x: column*TokenView.columnValue, y: row*TokenView.rowValue, width: TokenView.columnValue, height: TokenView.rowValue))
        
        self.refresh(token)
    }
    
    func refresh(token : Token){
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        self.token  = token
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: TokenView.columnValue, height: TokenView.rowValue))
        let labelStr = "\(self.token!.tokenColor) \(self.token!.number)"
        label.text = labelStr
        label.font = label.font.fontWithSize(13)
        
        self.addSubview(label)
    }
    
}
