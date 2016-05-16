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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showBurnAlert:", name: "burn", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "chooseAsValue:", name: "displayAsChoice", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "displayResult:", name: "displayEndTurn", object: nil)
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
        
        self.playerViews = [PlayerView]()
        
        self.playerViews!.append(self.playerView1)
        self.playerViews!.append(self.playerView2)
        self.playerViews!.append(self.playerView3)
        self.playerViews!.append(self.playerView4)
        
        self.playerView1!.backgroundColor = UIColor(netHex: 0x29a329)
        self.playerView4!.backgroundColor = UIColor(netHex: 0x29a329)
        self.playerView2!.backgroundColor = UIColor(netHex: 0x5cd65c)
        self.playerView3!.backgroundColor = UIColor(netHex: 0x5cd65c)
        
        self.dealer = dealer
        
        self.drawUI()
        self.refreshUI()
        
        self.dealerHandView.frame = CGRect(x: 0, y: 30, width: HandView.columnValue, height: HandView.rowValue)
        
        self.realPlayerBet(false)
        
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
    
    func realPlayerBet(errorBet : Bool){
        var str : String
        
        if errorBet{
            str = "Enter a number to bet, the last you typed was incompatible with your pot"
        }
        else{
            str = "Enter a number to bet"
        }
        let alert = UIAlertController(title: "Bet", message: str , preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.placeholder = "Bet number"
            textField.keyboardType = UIKeyboardType.NumberPad
        })
        
        alert.addAction(UIAlertAction(title: "Bet", style: .Default, handler: { (action) -> Void in
        
            if let number = Int(alert.textFields![0].text!){
                if let bet = self.dealer!.realPlayer.numberToBet(number)
                {
                    self.dealer!.realPlayer.currentBet = bet
                
                    self.dealer!.realPlayer.pot.minusPot(bet)
                    self.dealer!.randomBet()
                    
                    self.dealer!.startGame()
                    
                    
                    self.refreshUI()
                    
                    self.dealerHandView.subviews[1].hidden = true
                
                    self.actionButton.enabled = true
                    self.actionButton.alpha = 1.0
                }
                else{
                    self.realPlayerBet(true)
                }
            }
            else{
                self.realPlayerBet(true)
            }
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func chooseAsValue(object: AnyObject){
        let alert = UIAlertController(title: "As value", message: "Choose a value for your hand...", preferredStyle: UIAlertControllerStyle.Alert)

        let valueAsAsEleven = self.dealer!.realPlayer.valueWithAsAsEleven()
        let valueAsAsOne    = self.dealer!.realPlayer.valueWithAsAsOne()
        
        let asOneAction = UIAlertAction.self.init(title: "\(valueAsAsOne)", style: .Default) { (action) -> Void in
            if self.dealer!.realPlayer.separatedHand != nil && self.dealer!.realPlayer.standForMainHand{
                self.dealer!.realPlayer.asAsElevenSepHand = false
            }
            else{
                self.dealer!.realPlayer.asAsEleven = false
            }
            self.refreshUI()
        }
        alert.addAction(asOneAction)
        
        let asElevenAction = UIAlertAction.self.init(title: "\(valueAsAsEleven)", style: .Default) { (action) -> Void in
            if self.dealer!.realPlayer.separatedHand != nil && self.dealer!.realPlayer.standForMainHand{
                self.dealer!.realPlayer.asAsElevenSepHand = true
            }
            else{
                self.dealer!.realPlayer.asAsEleven = true
            }
            self.refreshUI()
        }
        alert.addAction(asElevenAction)
    
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    func showBurnAlert(object: AnyObject){
        let alert = UIAlertController(title: "BURN", message: "You have gone over 21", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction.self.init(title: "OK", style: .Default) { (action) -> Void in
            if self.dealer!.realPlayer.separatedHand != nil {
                if self.dealer!.realPlayer.standForMainHand{
                    self.dealer!.realPlayer.standForSeparatedHand = true
                }
                self.dealer!.realPlayer.standForMainHand = true
            }
            else{
                self.dealer!.realPlayer.stillAlive = false
                self.actionButton.enabled = false
                self.actionButton.alpha = 0.3
                self.dealer!.randomPlayTurn()
                self.refreshUI()
            }
        }
        alert.addAction(okAction)        
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func draw (playerIndex : Int){
        self.dealer!.draw(playerIndex)
        self.playerViews![playerIndex].refresh(self.dealer!.players[playerIndex])
    }
    
    @IBAction func onClickAction(sender: AnyObject) {
        var str : String = "What to do... This is for the main hand"
        
        if self.dealer!.realPlayer.separatedHand != nil{
            if self.dealer!.realPlayer.standForMainHand{
                str = "What to do... This is for the separated hand"
            }
        }
        let alert = UIAlertController(title: "Action", message: str, preferredStyle: UIAlertControllerStyle.Alert)
        
        if self.dealer!.realPlayer.hand.canSeparate(){
            let separateAction = UIAlertAction.self.init(title: "Separate", style: .Default) { (action) -> Void in
                print("Separate")
                self.dealer!.playerSeparate(self.dealer!.realPlayer)
                self.refreshUI()
            }
            alert.addAction(separateAction)
        }
        
        let drawAction = UIAlertAction.self.init(title: "Draw", style: .Default) { (action) -> Void in
            print("Draw")
            self.draw(0)
            self.refreshUI()
        }
        alert.addAction(drawAction)
        
        if self.dealer!.realPlayer.hand.cards.count == 2 && self.dealer!.realPlayer.separatedHand == nil{
            let surrenderAction = UIAlertAction.self.init(title: "Surrender", style: .Default) { (action) -> Void in
                print("Surrender")
                self.dealer!.playerSurrender(self.dealer!.realPlayer)
                self.actionButton.enabled = false
                self.actionButton.alpha = 0.3
            }
            alert.addAction(surrenderAction)
        }
        
        if self.dealer!.hand.cards[0].value == .AS && !self.dealer!.realPlayer.insurrance && self.dealer!.realPlayer.hand.cards.count == 2{
            let insuranceAction = UIAlertAction.self.init(title: "Insurance", style: .Default) { (action) -> Void in
                print("Insurrance")
                self.dealer!.playerInsurrance(self.dealer!.realPlayer)
            }
            alert.addAction(insuranceAction)
        }
        
        if self.dealer!.realPlayer.canDouble(){
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
            
            if self.dealer!.realPlayer.nothingToDo(){
                self.actionButton.enabled = false
                self.actionButton.alpha = 0.3
                self.dealer!.randomPlayTurn()
                self.refreshUI()
            }
        }
        alert.addAction(standAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func displayResult(notification: NSNotification){
        let player = self.dealer!.realPlayer
        
        let dict = notification.object as! NSDictionary
        let str = dict["str"] as! String
        self.dealerHandView.subviews[1].hidden = false
        
        let alert = UIAlertController(title: "Turn finished", message: str, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction.self.init(title: "OK", style: .Default) { (action) -> Void in
                self.dealer!.restartTurn()
                self.actionButton.enabled = true
                self.actionButton.alpha = 1.0
                self.refreshUI()
        }
        alert.addAction(okAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var dealerHandView: HandView!
    @IBOutlet weak var playerView1: PlayerView!
    @IBOutlet weak var playerView2: PlayerView!
    @IBOutlet weak var playerView3: PlayerView!
    @IBOutlet weak var playerView4: PlayerView!
    @IBOutlet weak var actionButton: UIButton!
    
    
}

