//
//  LifeCounterHistoryViewController.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 8/26/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit

class LifeCounterHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Model
    var game: GameTracker!
    //BUT, maybe you should create a smaller stats object???? (I don't thinks so... but I'll keep that in mind)
    
    //MARK: Table View
    @IBOutlet weak var historyTableView: UITableView!{
        didSet{
            historyTableView.delegate = self
            historyTableView.dataSource = self
        }
    }
    
    //MARK: Table View Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return game.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = game.events[indexPath.row]
        
        switch event{
        case .PlayerInteraction(let interaction):
            if let cell = tableView.dequeueReusableCell(withIdentifier: "GameHistoryCell") as? GameHistoryCell{
                cell.infoLabel.text = "\(interaction.actor!.name) \(interaction.changeInLife! > 0 ? "healed" : "damaged") \(interaction.target!.name) for \(abs(interaction.changeInLife!))"
                return cell
            }
        case .TurnChange(let turnNumber):
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TurnCell"){
                cell.textLabel?.text = "Turn \(turnNumber)"
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    

}
