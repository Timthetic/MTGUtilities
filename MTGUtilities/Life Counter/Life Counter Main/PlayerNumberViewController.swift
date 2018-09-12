//
//  PlayerNumberViewController.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 8/22/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit

class PlayerNumberViewController: UIViewController {
    
    
    var numberOfPlayers = 2
    var startingLife = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerButtons.filter({button in
            return button.titleLabel!.text! == "2"}).first?.isSelected = true
        lifeButtons.filter({button in
            return button.titleLabel!.text! == "20"}).first?.isSelected = true
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "Start Life Counter"){
            if let LifeVC = segue.destination as? LifeCounterViewController{
                LifeVC.startingLifeTotal = startingLife
                LifeVC.numberOfPlayers = numberOfPlayers
                //LifeVC.hidesBottomBarWhenPushed = true
            }
        }
    }
    
    
    @IBOutlet var playerButtons: [UIButton]!

    @IBAction func OnePlayerTapped(_ sender: UIButton) {
        numberOfPlayers = 1
        selectOnly(button: sender, outOf: playerButtons)
    }
    @IBAction func TwoPlayersTapped(_ sender: UIButton) {
        numberOfPlayers = 2
        selectOnly(button: sender, outOf: playerButtons)
    }
    @IBAction func ThreePlayersTapped(_ sender: UIButton) {
        numberOfPlayers = 3
        selectOnly(button: sender, outOf: playerButtons)
    }
    @IBAction func FourPlayersTapped(_ sender: UIButton) {
        numberOfPlayers = 4
        selectOnly(button: sender, outOf: playerButtons)
    }
    
    @IBOutlet var lifeButtons: [UIButton]!
    
    @IBAction func TwentyLifeTapped(_ sender: UIButton) {
        startingLife = 20
        selectOnly(button: sender, outOf: lifeButtons)
    }
    @IBAction func ThirtyLifeTapped(_ sender: UIButton) {
        startingLife = 30
        selectOnly(button: sender, outOf: lifeButtons)
    }
    @IBAction func FortyLifeTapped(_ sender: UIButton) {
        startingLife = 40
        selectOnly(button: sender, outOf: lifeButtons)
    }
    
    
    /**
     Deselects all buttons in `collection`, then selects `button`
     - Parameter button: The button you want selected
     - Parameter collection: The collection you want deselected
     */
    func selectOnly(button: UIButton, outOf collection: [UIButton]) {
        for btn in collection{
            btn.isSelected = false
        }
        button.isSelected = true
    }

}
