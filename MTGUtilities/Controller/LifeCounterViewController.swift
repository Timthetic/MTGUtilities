//
//  LifeCounterViewController.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 8/20/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit

class LifeCounterViewController: UIViewController {
    
    var numberOfPlayers: Int!{
        didSet{
            createLifeBoxes()
        }
    }
    var lifeViews: [PlayerLifeView] = []
    
    
    @IBAction func NewGame(_ sender: Any) {
        layoutLifeBoxes()
    }
    
    func createLifeBoxes(){
        for item in lifeViews{
            item.removeFromSuperview()
        }
        for i in 0..<numberOfPlayers{
            let lifeView = PlayerLifeView(frame: CGRect.zero)
            ContentArea.addSubview(lifeView)
            lifeView.nameField.text = "Player \(i+1)"
            lifeView.lifeLabel.text = "20"
            lifeViews.append(lifeView)
        }
        layoutLifeBoxes()
    }
    
    func layoutLifeBoxes() {
        if numberOfPlayers == 2{
            lifeViews[0].frame = CGRect(x: 0, y: 0, width: ContentArea.frame.width, height: ContentArea.frame.height / 2)
            lifeViews[0].transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            lifeViews[1].frame = CGRect(x: 0, y: ContentArea.frame.height / 2, width: ContentArea.frame.width, height: ContentArea.frame.height / 2)
        }
        else if numberOfPlayers == 3{
            
        }
        else if numberOfPlayers == 4{
            
        }
    }
    
    @IBOutlet weak var ContentArea: UIView!
    
    override func viewDidLayoutSubviews() {
        layoutLifeBoxes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if numberOfPlayers == nil{
            numberOfPlayers = 2
        }
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

}
