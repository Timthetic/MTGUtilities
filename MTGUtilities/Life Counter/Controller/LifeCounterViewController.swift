//
//  LifeCounterViewController.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 8/20/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit

class LifeCounterViewController: UIViewController, PlayerLifeViewDelegate {
 

    var numberOfPlayers: Int!
    
    var startingLifeTotal = 20
    var lifeViews: [PlayerLifeView] = []
    var passButton: UIButton = {
        var button = UIButton()
        button.setTitle("Pass", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.addTarget(self, action: #selector(passButtonPressed), for: UIControlEvents.touchUpInside)
        return button
    }()
    var dice: [Die] = []
    
    @IBOutlet weak var ContentArea: UIView!
    
    @IBAction func diceButtonTapped(_ sender: Any) {
        rollDice()
    }
    
    func rollDice(){
        for lifeView in lifeViews{
            if game.gameState == .playing{
                lifeView.isUserInteractionEnabled = false
            }
            let newDie = Die(withSideLength: lifeView.frame.smallestSide / 4, x: lifeView.bounds.origin.x, y: lifeView.bounds.origin.y)
            dice.append(newDie)
            lifeView.addSubview(newDie)
        }
        passButton.isUserInteractionEnabled = false
    }
    
    //MARK: Model
    lazy var game = GameTracker(numberOfPlayers: numberOfPlayers, startingLife: startingLifeTotal)
    var players = [(Player,PlayerLifeView)]()
    
    //MARK: PlayerLifeViewDelegate
    func minusTapped(forPlayerLifeView lifeView: PlayerLifeView) {
        switch game.gameState{
        case .choosingTurnOrder:
            if let player = playerFor(view: lifeView)
            {
                addPlayerToTurnOrder(player: player)
            }
        case .playing:
            if let player = playerFor(view: lifeView){
                game.changeLifeOf(player: player, by: -1)
            }
        }
        
        updateUI()
    }
    
    func plusTapped(forPlayerLifeView lifeView: PlayerLifeView) {
        switch game.gameState {
        case .choosingTurnOrder:
            if let player = playerFor(view: lifeView)
            {
                addPlayerToTurnOrder(player: player)
            }
        case .playing:
            if let player = playerFor(view: lifeView){
                game.changeLifeOf(player: player, by: 1)
            }
        }
        
        updateUI()
    }
    
    func nameSingleTapped(forPlayerLifeView lifeView: PlayerLifeView) {
//        switch gameState{
//        case .choosingTurnOrder:
//            break
//        case .playing:
//            if playerFor(view: lifeView) == game.activePlayer{
//                game.passTurn()
//                updateUI()
//            }
//        }
        
    }
    
    func nameDoubleTapped(forPlayerLifeView lifeView: PlayerLifeView) {
        let alert = UIAlertController(title: "Enter Name", message: "Enter a name for \(lifeView.nameLabel.text ?? String())", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { textField in
            textField.autocapitalizationType = .words
            
        })
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self, weak alert] (_) in
            self?.playerFor(view: lifeView)?.name = alert!.textFields![0].text!
            self?.updateUI()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func addPlayerToTurnOrder(player: Player){
        do{
            try game.setForNextTurn(player: player)
        } catch {
            print("Player Not In Game")
            assertionFailure()
        }
        
        if game.numberOfTurnsSet == players.count{
            //All Players have been mapped
            game.gameState = .playing
            for die in dice{
                die.removeFromSuperview()
            }
            dice = []
        }
    }
    
    @objc func passButtonPressed(){
        if game.gameState == .playing{
            game.passTurn()
            updateUI()
        }
    }
    @IBAction func ContentAreaTapped(_ sender: UITapGestureRecognizer) {
        for lifeView in lifeViews{
            lifeView.isUserInteractionEnabled = true
        }
        passButton.isUserInteractionEnabled = true
        for die in dice{
            die.removeFromSuperview()
        }
        dice = []
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
            switch game.gameState{
            case .choosingTurnOrder:        //If turns are being set up
                
                var turn = game.players.index(of: player)
                
                //The turn is invalid if it hasn't been set yet
                if let turnNumber = turn?.magnitude, Int(turnNumber) >= game.numberOfTurnsSet{
                    turn = nil
                }
                    
                    
                view.lifeLabel.text = (turn == nil ? "#" : "\((turn!.magnitude + 1))")
                view.nameLabel.text = "\(player.name)"
            case .playing:                  //If they're playing
                view.lifeLabel.text = "\(player.life)"
                view.nameLabel.text = "\(player.name)"
                if player == game.activePlayer{
                    view.strokeColor = UIColor.orange
                    //view.passButton.isHidden = false
                } else{
                    view.strokeColor = nil
                    //view.passButton.isHidden = true
                }
            }
        }
    }
    
    //MARK: Setup
    @IBAction func ResetGame(_ sender: Any) {
        createPlayers()
        updateUI()
    }
    
    func createPlayers(){
        //Remove old life boxes
        for item in lifeViews{
            item.removeFromSuperview()
        }
        //Remove old Players
        game = GameTracker(numberOfPlayers: numberOfPlayers, startingLife: startingLifeTotal)
        lifeViews = []
        players = []
        
        
        for i in 0..<numberOfPlayers{
            //Create new life box
            let lifeView = PlayerLifeView(frame: CGRect.zero)
            ContentArea.addSubview(lifeView)
            lifeView.nameLabel.text = "Player \(i+1)"
            lifeView.lifeLabel.text = "\(startingLifeTotal)"
            lifeView.delegate = self
            ContentArea.addSubview(lifeView)
            lifeViews.append(lifeView)
            
            //Add the combo to the list
            players.append((game.players[i], lifeView)) //We know I is in range because i < numberOfPlayers
        }
        layoutLifeBoxes()
    }
    
    func layoutLifeBoxes() {
        let contentHeight = ContentArea.frame.height
        let contentWidth = ContentArea.frame.width
        
        if numberOfPlayers == 1{
            lifeViews[0].frame = CGRect(x: 0, y: contentHeight / 4, width: contentWidth, height: contentHeight / 2)
        }
        else if numberOfPlayers == 2{
            let buttonPosition = contentHeight * (0.5 - Consts.HORIZONTAL_GAP_BETWEEN_LIFEVIEWS / 2)
            let buttonHeight = contentHeight * (Consts.HORIZONTAL_GAP_BETWEEN_LIFEVIEWS)
            lifeViews[0].frame = CGRect(x: 0,
                                        y: 0,
                                        width: contentWidth,
                                        height: buttonPosition)
            lifeViews[0].transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            lifeViews[1].frame = CGRect(x: 0,
                                        y: buttonPosition + buttonHeight,
                                        width: contentWidth,
                                        height: ContentArea.frame.height - buttonHeight - buttonPosition)
            passButton.frame = CGRect(x: 0,
                                      y: buttonPosition,
                                      width: contentWidth,
                                      height: buttonHeight)
            
        }
        else if numberOfPlayers == 3{
            let buttonPosition = contentHeight * (0.65 - Consts.HORIZONTAL_GAP_BETWEEN_LIFEVIEWS / 2)
            let buttonHeight = contentHeight * (Consts.HORIZONTAL_GAP_BETWEEN_LIFEVIEWS)
            passButton.frame = CGRect(x: 0,
                                      y: buttonPosition,
                                      width: contentWidth,
                                      height: buttonHeight)
            lifeViews[0].frame = CGRect(x: 0,
                                        y: buttonPosition + buttonHeight,
                                        width: contentWidth,
                                        height: contentHeight - buttonPosition - buttonHeight)
            
            lifeViews[1].frame = CGRect(x: 0,
                                        y: 0,
                                        width: contentWidth / 2,
                                        height: buttonPosition)
            
            
            lifeViews[1].transform = CGAffineTransform(rotationAngle: CGFloat.pi * (1/2))
            lifeViews[2].frame = CGRect(x: contentWidth / 2,
                                        y: 0,
                                        width: contentWidth / 2,
                                        height: buttonPosition)
           
            lifeViews[2].transform = CGAffineTransform(rotationAngle: CGFloat.pi * (3/2))
        }
        else if numberOfPlayers == 4{
            let buttonPosition = contentHeight * (0.5 - Consts.HORIZONTAL_GAP_BETWEEN_LIFEVIEWS / 2)
            let buttonHeight = contentHeight * (Consts.HORIZONTAL_GAP_BETWEEN_LIFEVIEWS)
            passButton.frame = CGRect(x: 0,
                                      y: buttonPosition,
                                      width: contentWidth,
                                      height: buttonHeight)
            
            lifeViews[0].frame = CGRect(x: 0, y: 0, width: contentWidth / 2, height: buttonPosition)
            lifeViews[0].transform = CGAffineTransform(rotationAngle: CGFloat.pi * (1/2))
            lifeViews[1].frame = CGRect(x: contentWidth / 2, y: 0, width: contentWidth / 2, height: buttonPosition)
            lifeViews[1].transform = CGAffineTransform(rotationAngle: CGFloat.pi * (3/2))
            lifeViews[2].frame = CGRect(x: 0, y: buttonPosition + buttonHeight, width: contentWidth / 2, height: contentHeight - buttonHeight - buttonPosition)
            lifeViews[2].transform = CGAffineTransform(rotationAngle: CGFloat.pi * (1/2))
            lifeViews[3].frame = CGRect(x: contentWidth / 2, y: buttonPosition + buttonHeight, width: contentWidth / 2, height: contentHeight - buttonHeight - buttonPosition)
            lifeViews[3].transform = CGAffineTransform(rotationAngle: CGFloat.pi * (3/2))
        }
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutLifeBoxes()
        passButton.titleLabel?.font = passButton.titleLabel?.font.withSize(ContentArea.frame.height * Consts.FONT_TO_HEIGHT)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if numberOfPlayers == nil{
            numberOfPlayers = 2
        }
        ContentArea.addSubview(passButton)
        createPlayers()
        updateUI()
        
        // Do any additional setup after loading the view.
    }

}

extension CGRect{
    var smallestSide: CGFloat{
        return width > height ? height : width
    }
}
