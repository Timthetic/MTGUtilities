//
//  SettingsViewController.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/2/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit
import CoreData

//FIXME: Not all rulings are loaded
//FIXME: I'm pretty sure I have some pretty bad memory leakage going on here
class SettingsViewController: UIViewController {

    let baseURL = "https://mtgjson.com/api/v5"
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    let context = (UIApplication.shared.delegate as? AppDelegate)!.privateContext
    
    var progress: (complete: Float, total: Float) = (0,1)
    var uiProgress: Float{
        return pow(progress.complete / progress.total, 2)
    }
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func updateButtonPressed() {
//        let url = URL(string: "https://mtgjson.com/json/AllSets-x.json")!
//        let task = URLSession.shared.dataTask(with: url){data, responce, error in
//            if let error = error{
//                print("\(error)")
//            }
//        }
    }
    
    ///Loads of the entire database.  Does not replace existing entries.
    @IBAction func createButtonPressed() {
        let url = URL(string: "\(baseURL)/SetList.json")!
        let task = URLSession.shared.dataTask(with: url){[weak self] data, responce, error in
            if let error = error{
                print("\(error)")
            }
            if let data = data{
                //Parse json
                if let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]{
                    self?.progress.total = Float(json.count)
                    
                    //Fetches cards set by set
                    for setsList in json["data"] as! [Any] {
                        if let set = setsList as? [String:Any]{
                            print(set["name"] ?? "nopexxx")
                            let setCode = set["code"] as? String
                            self?.fetchSet(byCode: setCode, intoContext: self?.context)
                        }
                    }
                    
                }
            }
        }
        task.resume()
    }
    
    /**
     Fetches a set by its code into the database context.
     
     - Parameters:
        - name: The set's full name
        - code: The set's code
        - context: The database context
     */
    func fetchSet(byCode code: String?, intoContext context: NSManagedObjectContext?) {
        //check if set is valid
        guard let code = code else{
            print("CardSet has not code!  Must return.")
            return
        }
        //Check for context
        guard let context = context else{
            print("I can't insert into a nil context.")
            return
        }
        
        //Get set from MTGJson
        let url = URL(string: "\(baseURL)/\(code).json")!
        let task = URLSession.shared.dataTask(with: url){[weak self] data, responce, error in
            if let error = error{
                print("\(error)")
            }
            guard let data = data else{
                return
            }
            
            if let setObj = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]{
                //Finds the 'cards' section of the json object
                
                guard let set = setObj["data"] as? [String:Any] else {
                    print("Couldn't parse set")
                    return
                }
                
                let name = set["name"] as! String
                let code = set["code"] as! String
                let stringDate = set["releaseDate"] as! String
                
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let releaseDate = formatter.date(from: stringDate)! as NSDate
                CardSet.addSet(name: name, code: code, date: releaseDate, intoContext: context)
                
                if let cards = set["cards"] as? [[String: Any]]{
                    for card in cards{
                        do{
                            //Insert card into database
                            //FIXME: Don't cram data into a million different forms
                            let newCard = try JSONSerialization.data(withJSONObject: card, options: JSONSerialization.WritingOptions.sortedKeys)
                            //This is where the card is set
                            if let jsonCard = try? JSONDecoder().decode(JsonCard.self, from: newCard){
                                jsonCard.setName = name
                                print("Inserting \(jsonCard.name ?? "UNKNOWN")")
                                jsonCard.setCode = code
                                context.perform {
                                    Card.insertCardFrom(jsonCard: jsonCard, inManagedObjectContext: context)
                                }
                            }
                            
                        } catch(let error){
                            print("\(error)")
                        }
                        
                    }
                }
                context.performAndWait {
                    //Save changes
                    if context.hasChanges{
                        do{
                            try context.save()
                            print("Saved \(name)")
                        }catch(let error){
                            print(error)
                        }
                    }
                }
            }
            else{
                print(String(data: data, encoding: .utf8) ?? "[Unreadable Data]")
            }

            
            DispatchQueue.main.async {
                //Marks progress
                self?.progress.complete += 1
                self?.progressBar.progress = self?.uiProgress ?? 0.0
                if self?.progress.complete == self?.progress.total{
                    self?.progressBar.progressTintColor = UIColor.green
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
