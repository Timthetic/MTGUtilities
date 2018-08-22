//
//  LifeCounterViewController.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 8/20/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit

class LifeCounterViewController: UIViewController, PlayerLifeViewDelegate {
    
    var numberOfPlayers: Int!{
        didSet{
            createPlayers()
        }
    }
    var lifeViews: [PlayerLifeView] = []
    
    @IBOutlet weak var ContentArea: UIView!
    
    //MARK: Model
    var game = GameTracker()
    var players = [(Player,PlayerLifeView)]()
    
    //MARK: PlayerLifeViewDelegate
    func minusTapped(forPlayerLifeView lifeView: PlayerLifeView) {
        playerFor(view: lifeView)?.changeLife(by: -1, from: game.activePlayer)
        updateUI()
    }
    
    func plusTapped(forPlayerLifeView lifeView: PlayerLifeView) {
        playerFor(view: lifeView)?.changeLife(by: +1, from: game.activePlayer)
        updateUI()
    }
    
    //MARK: Bridging Model and View
    func playerFor(view: PlayerLifeView) -> Player?{
        for playerItem in players{
            let (otherPlayer, otherView) = playerItem
            if otherView == view{
                return otherPlayer
            }
        }
        return nil
    }
    
    func viewFor(player: Player) -> PlayerLifeView?{
        for playerItem in players{
            let (otherPlayer, otherView) = playerItem
            if otherPlayer == player{
                return otherView
            }
        }
        return nil
    }

    
    //MARK: Update View From Model
    
    func updateUI(){
        for (player, view) in players{
            view.lifeLabel.text = "\(player.life)"
            if player == game.activePlayer{
                view.strokeColor = UIColor.orange
            } else{
                view.strokeColor = nil
            }
        }
    }
    
    //MARK: Setup
    @IBAction func NewGame(_ sender: Any) {
        createPlayers()
    }
    
    func createPlayers(){
        //Remove old life boxes
        for item in lifeViews{
            item.removeFromSuperview()
        }
        //Remove old Players
        game = GameTracker()
        lifeViews = []
        
        for i in 0..<numberOfPlayers{
            //Create new life box
            let lifeView = PlayerLifeView(frame: CGRect.zero)
            ContentArea.addSubview(lifeView)
            lifeView.nameLabel.text = "Player \(i+1)"
            lifeView.lifeLabel.text = "20"
            lifeView.delegate = self
            lifeViews.append(lifeView)
            
            //Create new player
            let newPlayer = Player(name: "Player \(i+1)")
            game.players.append(newPlayer)
            
            //Add the combo to the list
            players.append((newPlayer, lifeView))
        }
        layoutLifeBoxes()
    }
    
    func layoutLifeBoxes() {
        let contentHeight = ContentArea.frame.height
        let contentWidth = ContentArea.frame.width
        if numberOfPlayers == 2{
            lifeViews[0].frame = CGRect(x: 0, y: 0, width: contentWidth, height: contentHeight / 2)
            lifeViews[0].transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            lifeViews[1].frame = CGRect(x: 0, y: contentHeight / 2, width: contentWidth, height: contentHeight / 2)
        }
        else if numberOfPlayers == 3{
            lifeViews[0].frame = CGRect(x: 0, y: contentHeight * (2/3), width: contentWidth, height: contentHeight / 3)
            lifeViews[1].frame = CGRect(x: 0, y: 0, width: contentWidth / 2, height: contentHeight * (2/3))
            lifeViews[1].transform = CGAffineTransform(rotationAngle: CGFloat.pi * (1/2))
            lifeViews[2].frame = CGRect(x: contentWidth / 2, y: 0, width: contentWidth / 2, height: contentHeight * (2/3))
            lifeViews[2].transform = CGAffineTransform(rotationAngle: CGFloat.pi * (3/2))
        }
        else if numberOfPlayers == 4{
            lifeViews[0].frame = CGRect(x: 0, y: 0, width: contentWidth / 2, height: contentHeight * (1/2))
            lifeViews[0].transform = CGAffineTransform(rotationAngle: CGFloat.pi * (1/2))
            lifeViews[1].frame = CGRect(x: contentWidth / 2, y: 0, width: contentWidth / 2, height: contentHeight * (1/2))
            lifeViews[1].transform = CGAffineTransform(rotationAngle: CGFloat.pi * (3/2))
            lifeViews[2].frame = CGRect(x: 0, y: contentHeight / 2, width: contentWidth / 2, height: contentHeight * (1/2))
            lifeViews[2].transform = CGAffineTransform(rotationAngle: CGFloat.pi * (1/2))
            lifeViews[3].frame = CGRect(x: contentWidth / 2, y: contentHeight / 2, width: contentWidth / 2, height: contentHeight * (1/2))
            lifeViews[3].transform = CGAffineTransform(rotationAngle: CGFloat.pi * (3/2))
        }
    }

    
    override func viewDidLayoutSubviews() {
        layoutLifeBoxes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if numberOfPlayers == nil{
            numberOfPlayers = 4
        }
        updateUI()
        
        // Do any additional setup after loading the view.
    }

}
