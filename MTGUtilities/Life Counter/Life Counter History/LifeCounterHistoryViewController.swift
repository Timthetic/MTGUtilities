//
//  LifeCounterHistoryViewController.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 8/26/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit

// New Idea: Create n sections and up to m cells in each section
// n: number of turns, m: number of players choose 2 (p!/(2*(p-2)!) ~ p^2)

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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return game.turns.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        let turnNumber = game.turns[section].number ?? 0
        let turnPlayer = game.turns[section].owner.name
        label.text = "Turn \(turnNumber) -- \(turnPlayer)"
        label.font = label.font.bold()
        return label
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CONSTS.HEIGHT_OF_TURN_HEADER
    }
    
    //MARK: Table View Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return game.turns[section].interactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the n-th interaction for the m-th turn
        // n = row number, m = section number
        let interaction = game.turns[indexPath.section].interactions[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GameHistoryCell") as? GameHistoryCell{
            cell.infoLabel.text = "\(interaction.actor!.name) \(interaction.changeInLife! > 0 ? "healed" : "damaged") \(interaction.target!.name) for \(abs(interaction.changeInLife!))"
            return cell
        }
        return UITableViewCell()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    

}
