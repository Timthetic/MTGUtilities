//
//  DeckViewController.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/18/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit
import CoreData

class DeckViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CardSearchDelegate {

    var deck: Deck?
    var context: NSManagedObjectContext!
    
    lazy var cards: [DeckCard]? = {
        return deck?.cards?.sorted(by: {return $0.baseCard?.cmc ?? 0 > $1.baseCard?.cmc ?? 0})
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deck?.cards?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "") as? DeckCardCell{
            cell.nameLabel.text = cards?[indexPath.row].baseCard?.name
            cell.quantityLabel.text = "x\(cards?[indexPath.row].quantity ?? 0)"
            return cell
        }
        return UITableViewCell()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = deck?.name

        // Do any additional setup after loading the view.
    }
    @IBAction func AddButtonTapped(_ sender: Any) {
        present(createVC(withSBIdentifier: "SearchVC"), animated: true, completion: nil)
    }
    
    func recieve(uniqueCard: UniqueCard, quantity: Int) {
        guard let deck = deck else{
            return
        }
        DeckCard.set(uniqueCard: uniqueCard, ofQuanity: quantity, forDeck: deck, withContext: context)
        
    }

}
