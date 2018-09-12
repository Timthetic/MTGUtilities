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

    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    let context = (UIApplication.shared.delegate as? AppDelegate)!.privateContext
    
    var progress: (complete: Float, total: Float) = (0,1)
    var uiProgress: Float{
        return progress.complete / progress.total
    }
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func updateButtonPressed() {
        let url = URL(string: "https://mtgjson.com/json/AllSets-x.json")!
        let task = URLSession.shared.dataTask(with: url){data, responce, error in
            if let error = error{
                print("\(error)")
            }
        }
    }
    
    ///Loads of the entire database.  Does not replace existing entries.
    @IBAction func createButtonPressed() {
        let url = URL(string: "https://mtgjson.com/json/SetList.json")!
        let task = URLSession.shared.dataTask(with: url){[weak self] data, responce, error in
            if let error = error{
                print("\(error)")
            }
            if let data = data{
                //Parse json
                if let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [Any]{
                    self?.progress.total = Float(json.count)
                    
                    //Fetches cards set by set
                    for setsList in json{
                        if let set = setsList as? [String:String]{
                            print(set["name"] ?? "nopexxx")
                            let setName = set["name"]
                            let setCode = set["code"]
                            self?.fetchSet(name: setName, code: setCode, intoContext: self?.context)
                            
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
    func fetchSet(name: String?, code: String?, intoContext context: NSManagedObjectContext?) {
        guard let code = code else{
            print("Set has not code!  Must return.")
            return
        }
        guard let context = context else{
            print("I can't insert into a nil context.")
            return
        }
        
        let url = URL(string: "https://mtgjson.com/json/\(code)-x.json")!
        let task = URLSession.shared.dataTask(with: url){[weak self] data, responce, error in
            if let error = error{
                print("\(error)")
            }
            guard let data = data else{
                return
            }
            if let set = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]{
                //Finds the 'cards' section of the json object
                if let cards = set["cards"] as? [[String: Any]]{
                    for card in cards{
                        do{
                            //Insert card into database
                            //FIXME: Don't cram data into a million different forms
                            //FIXME: Also I'm pretty sure card, newCard, and jsonCard are all passed by VALUE. RIP memory.
                            let newCard = try JSONSerialization.data(withJSONObject: card, options: JSONSerialization.WritingOptions.sortedKeys)
                            if let jsonCard = JsonCard(json: newCard, setCode: code, setName: name){
                                context.perform {
                                    Card.insertCardFrom(jsonCard: jsonCard, inManagedObjectContext: context)
                                }
                            }
                            
                        } catch(let error){
                            print("\(error)")
                        }
                        
                    }
                }
            }
            context.performAndWait {
                //Save changes
                if context.hasChanges{
                    do{
                        try context.save()
                        print("Saved \(name ?? "NO NAME")")
                    }catch(let error){
                        print(error)
                    }
                }
            }
            
            DispatchQueue.main.async {
                //Marks progress
                self?.progress.complete += 1
                self?.progressBar.progress = self?.uiProgress ?? 0.0
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
