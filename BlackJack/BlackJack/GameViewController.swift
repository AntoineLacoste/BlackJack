//
//  ViewController.swift
//  BlackJack
//
//  Created by Supinfo on 12/05/16.
//  Copyright © 2016 B3Ingesup. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var dealer : Dealer?
    
    var playerViews : [PlayerView]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.navigationBarHidden = true
        
        self.actionButton.enabled = false
        self.actionButton.alpha = 0.3
        
        let dealer = Dealer()
        
        let player1 = RandomPlayer(nickname: "THEREALPLAYER")
        let player2 = RandomPlayer(nickname: "Bob")
        let player3 = RandomPlayer(nickname: "Alice")
        let player4 = RandomPlayer(nickname: "Steeve")
        dealer.addPlayer(player1)
        dealer.addPlayer(player2)
        dealer.addPlayer(player3)
        dealer.addPlayer(player4)
        
        dealer.shuffleShoe()
        
        dealer.startGame()
        
        self.playerViews = [PlayerView]()
        
        self.playerViews!.append(self.playerView1)
        self.playerViews!.append(self.playerView2)
        self.playerViews!.append(self.playerView3)
        self.playerViews!.append(self.playerView4)
        
        self.dealer = dealer
        
        self.drawUI()
        self.refreshUI()
        
        self.dealerHandView.frame = CGRect(x: 0, y: 30, width: HandView.columnValue, height: HandView.rowValue)
        
        self.realPlayerBet()
        
    }
    
    func drawUI(){
        for index in 0..<self.playerViews!.count{
            self.playerViews![index].resize(index)
        }
    }
    
    func refreshUI(){
        dealerHandView.refresh(self.dealer!.hand)
        let player1 = self.dealer!.players[0]
        let player2 = self.dealer!.players[1]
        let player3 = self.dealer!.players[2]
        let player4 = self.dealer!.players[3]
        
        playerView1.refresh(player1)
        playerView2.refresh(player2)
        playerView3.refresh(player3)
        playerView4.refresh(player4)
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func realPlayerBet(){
        var alert = UIAlertController(title: "Bet", message: "Enter a number to bet", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.placeholder = "Blue token to bet"
            textField.keyboardType = UIKeyboardType.NumberPad
        })
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.placeholder = "Red token to bet"
            textField.keyboardType = UIKeyboardType.NumberPad
        })
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.placeholder = "Green token to bet"
            textField.keyboardType = UIKeyboardType.NumberPad
        })
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.placeholder = "Black token to bet"
            textField.keyboardType = UIKeyboardType.NumberPad
        })
        
        alert.addAction(UIAlertAction(title: "Bet", style: .Default, handler: { (action) -> Void in
            var blueToken  = 0
            var redToken   = 0
            var greenToken = 0
            var blackToken = 0
            
            //You can't bet more than your token
            blueToken  += min(Int(alert.textFields![0].text!)!, self.dealer!.realPlayer.pot.tokens[0].number)
            redToken   += min(Int(alert.textFields![1].text!)!, self.dealer!.realPlayer.pot.tokens[1].number)
            greenToken += min(Int(alert.textFields![2].text!)!, self.dealer!.realPlayer.pot.tokens[2].number)
            blackToken += min(Int(alert.textFields![3].text!)!, self.dealer!.realPlayer.pot.tokens[3].number)
        
            let bet = Pot(blueToken, redToken, greenToken, blackToken)
            
            self.dealer!.realPlayer.currentBet = bet
            
            self.dealer!.realPlayer.pot.minusPot(bet)
            self.refreshUI()
            
            self.actionButton.enabled = true
            self.actionButton.alpha = 1.0
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    func draw (playerIndex : Int){
        self.dealer!.players[playerIndex].hand.addCard(self.dealer!.cardShoe.drawCard())
        self.playerViews![playerIndex].refresh(self.dealer!.players[playerIndex])
    }
    
    @IBAction func onClickAction(sender: AnyObject) {
        let alert = UIAlertController(title: "Action", message: "What to do...", preferredStyle: UIAlertControllerStyle.Alert)
        
        /*let separateAction = UIAlertAction.self.init(title: "Separate", style: .Default) { (action) -> Void in
            print("Separate")
        }*/
        let drawAction = UIAlertAction.self.init(title: "Draw", style: .Default) { (action) -> Void in
            print("Draw")
            self.draw(0)
        }
        alert.addAction(drawAction)
        
        if self.dealer!.realPlayer.hand.cards.count == 2{
            let surrenderAction = UIAlertAction.self.init(title: "Surrender", style: .Default) { (action) -> Void in
                print("Surrender")
                self.dealer!.playerSurrender(self.dealer!.realPlayer)
            }
            alert.addAction(surrenderAction)
        }
        
        if self.dealer!.hand.cards[0].value == .AS && !self.dealer!.realPlayer.insurrance{
            let insuranceAction = UIAlertAction.self.init(title: "Insurance", style: .Default) { (action) -> Void in
                print("Insurrance")
                self.dealer!.playerInsurrance(self.dealer!.realPlayer)
            }
            alert.addAction(insuranceAction)
        }
        
        if self.dealer!.realPlayer.hand.canDouble(){
            let doubleAction = UIAlertAction.self.init(title: "Double", style: .Default) { (action) -> Void in
                print("Double")
                self.dealer!.playerDouble(self.dealer!.realPlayer)
                self.refreshUI()
            }
            alert.addAction(doubleAction)
        }
        
        let standAction = UIAlertAction.self.init(title: "Stand", style: .Default) { (action) -> Void in
            print("Stand")
            self.dealer!.playerStand(self.dealer!.realPlayer)
        }
        alert.addAction(standAction)
        
        //alert.addAction(separateAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var dealerHandView: HandView!
    @IBOutlet weak var playerView1: PlayerView!
    @IBOutlet weak var playerView2: PlayerView!
    @IBOutlet weak var playerView3: PlayerView!
    @IBOutlet weak var playerView4: PlayerView!
    @IBOutlet weak var actionButton: UIButton!
    
    
}

