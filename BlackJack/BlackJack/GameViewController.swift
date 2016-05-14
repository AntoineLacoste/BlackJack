//
//  ViewController.swift
//  BlackJack
//
//  Created by Supinfo on 12/05/16.
//  Copyright © 2016 B3Ingesup. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.navigationBarHidden = true
        
        let dealer = Dealer()
        
        let player1 = RandomPlayer(nickname: "roger1")
        let player2 = RandomPlayer(nickname: "roger2")
        let player3 = RandomPlayer(nickname: "roger3")
        let player4 = RandomPlayer(nickname: "roger4")
        dealer.addPlayer(player1)
        dealer.addPlayer(player2)
        dealer.addPlayer(player3)
        dealer.addPlayer(player4)
        
        dealer.shuffleShoe()
        var cards = [Int]()
        for index in 0...311{
            let card = dealer.cardShoe.cards[index]
            
            if !card.isRed  {
                cards.append(card.BJValue)
            }
            else{
                cards.append(666)
            }
        }
        print(cards)
        print(cards.count)
        
        dealer.startGame()
        
        dealerHandView.refresh(dealer.hand)
        playerView1.refresh(player1.hand, player1.pot)
        playerView2.refresh(player2.hand, player2.pot)
        playerView3.refresh(player3.hand, player3.pot)
        playerView4.refresh(player4.hand, player4.pot)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var dealerHandView: HandView!
    @IBOutlet weak var playerView1: PlayerView!
    @IBOutlet weak var playerView2: PlayerView!
    @IBOutlet weak var playerView3: PlayerView!
    @IBOutlet weak var playerView4: PlayerView!
}

