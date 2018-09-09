//
//  LifeCounterCustomizationViewController.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 8/28/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit

class LifeCounterCustomizationViewController: UITableViewController, PlayerCellDelegate {
    
    var players: [(Player, PlayerLifeView)]!
    
    //MARK: - PlayerCellDelegate Meathods
    
    func nameDidChange(to name: String, forPlayerCell playerCell: PlayerCell) {
        if let index = tableView.indexPath(for: playerCell){
            players[index.row].0.name = name
        }
    }
    func colorDidChange(to color: UIColor, forPlayerCell playerCell: PlayerCell) {
        if let index = tableView.indexPath(for: playerCell){
            players[index.row].1.fillColor = color
        }
    }
    
    

    //MARK: - View Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        for view in tableView.visibleCells{
            if let cell = view as? PlayerCell{
                if cell.playerNameField.isFirstResponder{
                    cell.delegate?.nameDidChange(to: cell.playerNameField.text ?? "", forPlayerCell: cell)
                }
            }
        }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return players.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCustomCell", for: indexPath) as? PlayerCell{
            let player = players[indexPath.row]
            cell.playerNameField.text = player.0.name
            cell.trySelect(color: player.1.fillColor)
            cell.delegate = self
            return cell
        }

        // Configure the cell...

        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
