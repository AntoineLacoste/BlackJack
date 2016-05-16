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
    
    var separatedHandView : SeparatedHandView?
    
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
        var labelStr = "\(self.player!.nickname) : \(self.player!.BJValue)"
        if self.player!.BJValueSeparated != 0{
            labelStr += "-\(self.player!.BJValueSeparated)"
        }
        labelName.text = labelStr
        labelName.font = labelName.font.fontWithSize(18)
        
        
        self.handView = HandView(hand: hand)
        if let separatedHand = player.separatedHand{
            self.separatedHandView = SeparatedHandView(hand: separatedHand)
        }
        self.potView  = PotView(pot: pot)
        
        var nbCardInHandOverTwo = 0
        var cardSeparated       = 0
        
        if let separatedHand = player.separatedHand{
            self.separatedHandView = SeparatedHandView(hand: separatedHand)
            cardSeparated = separatedHand.cards.count
        }
        
        let cards = max(hand.cards.count, cardSeparated)
        if cards >= 3{
            nbCardInHandOverTwo = cards - 2
        }
        
        self.betView  = BetView(bet: bet, nbCardInHandOverTwo)
        
        self.potView!.refresh(pot)
        self.handView!.refresh(hand)
        if let separatedHand = player.separatedHand{
            self.separatedHandView!.refresh(separatedHand)
        }
        self.betView!.refresh(bet)
        
        self.addSubview(labelName)
        self.addSubview(self.potView!)
        self.addSubview(self.handView!)
        if let _ = player.separatedHand{
            self.addSubview(self.separatedHandView!)
        }
        self.addSubview(self.betView!)
    }
}
