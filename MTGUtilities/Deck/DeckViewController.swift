//
//  DeckViewController.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/18/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit

class DeckViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var deck: Deck?
    
    lazy var cards: [DeckCard]? = {
        return deck?.cards?.sorted(by: {return $0.cardInfo?.baseCard?.cmc ?? 0 > $1.cardInfo?.baseCard?.cmc ?? 0})
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deck?.cards?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "") as? DeckCardCell{
            cell.nameLabel.text = cards?[indexPath.row].cardInfo?.baseCard?.name
            cell.quantityLabel.text = "x\(cards?[indexPath.row].quantity ?? 0)"
            return cell
        }
        return UITableViewCell()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
