//
//  SettingsViewController.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/2/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBAction func updateButtonPressed() {
        let url = URL(string: "https://mtgjson.com/json/AllSets-x.json")!
        let task = URLSession.shared.dataTask(with: url){data, responce, error in
            if let error = error{
                print("\(error)")
            }
            if let data = data{
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]{
                    for setsList in json{
                        if let set = setsList.value as? [String:Any]{
                            print(set["name"] ?? "nopexxx")
                            if let cards = set["cards"] as? [[String: Any]]{
                                for card in cards{
                                    do{
                                        let newCard = try JSONSerialization.data(withJSONObject: card, options: JSONSerialization.WritingOptions.sortedKeys)
                                        let jsonCard = JsonCard(json: newCard)
                                        print("\(jsonCard?.name)")
                                        
                                    } catch(let error){
                                        print("\(error)")
                                    }
                                    
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
