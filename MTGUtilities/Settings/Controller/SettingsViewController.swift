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
    
    @IBAction func createButtonPressed() {
        let url = URL(string: "https://mtgjson.com/json/SetList.json")!
        let task = URLSession.shared.dataTask(with: url){[weak self] data, responce, error in
            if let error = error{
                print("\(error)")
            }
            if let data = data{
                if let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [Any]{
                    self?.progress.total = Float(json.count)
                    
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
                if let cards = set["cards"] as? [[String: Any]]{
                    for card in cards{
                        do{
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
