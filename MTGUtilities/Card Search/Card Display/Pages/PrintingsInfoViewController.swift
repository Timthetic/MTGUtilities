//
//  PrintingsInfoViewController.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/10/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit

class PrintingsInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var printingsTableView: UITableView!{
        didSet{
            printingsTableView.delegate = self
            printingsTableView.dataSource = self
        }
    }
    
    var cardDataSource: CardDataSource?
    lazy var printings: [UniqueCard] = {
        //TODO: Sort by release date (this will require an extra attribute in the db model)
        if let cards = cardDataSource?.card?.printings?.allObjects as? [UniqueCard]{
            return cards
        }
        return []
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return printings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Printing Cell"){
            if let set = printings[indexPath.row].set{
                cell.textLabel?.text = "\(set.code ?? "") - \(set.name ?? "")"
            }
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cardDataSource?.uniqueCard = printings[indexPath.row]
    }
    
    func trySelect(uniqueCard: UniqueCard){
        for cardIndex in printings.indices{
            let card = printings[cardIndex]
            if card.multiverseId == uniqueCard.multiverseId{
                printingsTableView.selectRow(at: IndexPath(row: cardIndex, section: 0), animated: true, scrollPosition: .middle)
                cardDataSource?.uniqueCard = printings[cardIndex]
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if cardDataSource?.uniqueCard != nil{
            trySelect(uniqueCard: cardDataSource!.uniqueCard!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
