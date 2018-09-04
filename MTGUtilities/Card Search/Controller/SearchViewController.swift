//
//  SearchViewController.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 8/30/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit
import CoreData

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    let context: NSManagedObjectContext = (UIApplication.shared.delegate as? AppDelegate)!.managedObjectContext
//    let backgroundContext: NSManagedObjectContext = {
//        let ctxt = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
//        ctxt.parent = (UIApplication.shared.delegate as? AppDelegate)!.managedObjectContext
//        return ctxt
//    }()
    
    var fetchedCards = [Card](){
        didSet{
            tableView?.reloadData()
        }
    }
    var previousQuary = ""
    
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!{
        didSet{
            searchBar.delegate = self
        }
    }
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    //MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell"){
            cell.textLabel?.text = fetchedCards[indexPath.row].name
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedCards.count
    }
    
    //MARK: - UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text?.count ?? 0 < 3 {
            fetchedCards = []
            previousQuary = ""
            tableView.reloadData()
            return
        }
        
        guard let text = searchBar.text else{
            return
        }
        
        if previousQuary != "" && text.hasPrefix(previousQuary){
            fetchedCards = fetchedCards.filter({$0.name?.range(of: text) != nil})
            previousQuary = text
        }
        else{
            let request = NSFetchRequest<Card>(entityName: "Card")
            let predicate = NSPredicate(format: "name contains[c] %@", text)
            request.predicate = predicate
            context.perform {
                if let results = try? self.context.fetch(request){
//                    DispatchQueue.main.sync {
                        if text == self.searchBar.text{ //Only update if
                            self.previousQuary = text
                            self.fetchedCards = results
                        }
//                    }
                }
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
