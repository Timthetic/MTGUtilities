//
//  SearchViewController.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 8/30/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    let searchController = UISearchController(searchResultsController: nil)
    //TODO: Add filteredCards
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        tableView.tableHeaderView = self.searchController.searchBar
        definesPresentationContext = true;
        searchController.obscuresBackgroundDuringPresentation = false;
        searchController.searchBar.placeholder = "Search Cards"


        // Do any additional setup after loading the view.
    }

    func searchCards(_ text: String){
        //TODO: Search Database
    }
    
}
//MARK: - UISearchResultsUpdating Delegate
extension SearchViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        searchCards(searchController.searchBar.text!.lowercased())
    }
    
}
