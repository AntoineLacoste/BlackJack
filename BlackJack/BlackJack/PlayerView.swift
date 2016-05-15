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
    
    var betView : BetView?
    
    var player  : BlackJackPlayer?
    
    static let nameHeight : Int = 40
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func resize(playerNumber : Int) {
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        let playerViewWidth  = screenWidth * 0.5
        let playerViewHeight = (screenHeight - CGFloat(HandView.rowValue)) * 0.5
        
        var viewColumn : CGFloat = 0
        var viewRow    : CGFloat = 0
        
        switch playerNumber{
            case 1:
                viewColumn = 1
                viewRow    = 0
            case 2:
                viewColumn = 0
                viewRow    = 1
            case 3:
                viewColumn = 1
                viewRow    = 1
            default:
                viewColumn = 0
                viewRow    = 0
        }
        
        var marginTop = CGFloat(HandView.rowValue) + viewRow * playerViewHeight
        //Add the dealer's label's height
        marginTop += 25
        
        self.frame = CGRect(x: viewColumn * playerViewWidth, y: marginTop, width: playerViewWidth, height: playerViewHeight)
        
    }
    
    func refresh(player : BlackJackPlayer){
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        self.player = player
        
        let hand = player.hand
        let pot  = player.pot
        let bet  = player.currentBet
        
        let labelName = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: PlayerView.nameHeight))
        let labelStr = "\(self.player!.nickname)"
        labelName.text = labelStr
        labelName.font = labelName.font.fontWithSize(18)
        
        
        self.handView = HandView(hand: hand)
        self.potView  = PotView(pot: pot)
        
        var nbCardInHandOverTwo = 0
        
        if hand.cards.count >= 3{
            nbCardInHandOverTwo = hand.cards.count - 2
        }
        
        self.betView  = BetView(bet: bet, nbCardInHandOverTwo)
        
        self.potView!.refresh(pot)
        self.handView!.refresh(hand)
        self.betView!.refresh(bet)
        
        self.addSubview(labelName)
        self.addSubview(self.potView!)
        self.addSubview(self.handView!)
        self.addSubview(self.betView!)
    }
}
