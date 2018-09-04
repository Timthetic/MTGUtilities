//
//  SettingsViewController.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/2/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit
import CoreData


//FIXME: I'm pretty sure I have some pretty bad memory leakage going on here
class SettingsViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    let context = (UIApplication.shared.delegate as? AppDelegate)!.privateContext
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBAction func updateButtonPressed() {
        let url = URL(string: "https://mtgjson.com/json/AllSets-x.json")!
        let task = URLSession.shared.dataTask(with: url){data, responce, error in
            if let error = error{
                print("\(error)")
            }
            if let data = data{
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]{
                    let total = Float(json.count)
                    var done = Float(0)
                    for setsList in json{
                        if let set = setsList.value as? [String:Any]{
                            print(set["name"] ?? "nopexxx")
                            let setName = set["name"] as? String
                            let setCode = set["code"] as? String
                            if let cards = set["cards"] as? [[String: Any]]{
                                for card in cards{
                                    do{
                                        let newCard = try JSONSerialization.data(withJSONObject: card, options: JSONSerialization.WritingOptions.sortedKeys)
                                        if let jsonCard = JsonCard(json: newCard, setCode: setCode, setName: setName){
                                            self.context.perform {
                                                Card.insertCardFrom(jsonCard: jsonCard, inManagedObjectContext: self.context)
                                            }
                                        }
                                        
                                    } catch(let error){
                                        print("\(error)")
                                    }
                                    
                                }
                            }
                            self.context.performAndWait{
                                do {
                                    if self.context.hasChanges{
                                        try self.context.save()
                                        print("Saved \(set["name"] ?? "nopexxx")")
                                    }
                                } catch let error {
                                    print("Core Data Error: \(error)")
                                }
                                done += 1
                                DispatchQueue.main.async{
                                    self.progressBar.progress = done/total
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
