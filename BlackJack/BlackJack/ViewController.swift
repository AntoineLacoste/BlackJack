//
//  ViewController.swift
//  BlackJack
//
//  Created by Supinfo on 12/05/16.
//  Copyright © 2016 B3Ingesup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClickButton(sender: AnyObject) {
        let dealer = Dealer()
        
        dealer.addPlayer(RandomPlayer(nickname: "roger1"))
        dealer.addPlayer(RandomPlayer(nickname: "roger2"))
        dealer.addPlayer(RandomPlayer(nickname: "roger3"))
        dealer.addPlayer(RandomPlayer(nickname: "roger4"))
        
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
    }
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var labelNbPlayer: UILabel!

    @IBOutlet weak var nbPlayerTextField: UITextField!
}

