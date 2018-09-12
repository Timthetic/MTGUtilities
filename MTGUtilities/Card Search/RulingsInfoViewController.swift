//
//  RulingsInfoViewController.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/6/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit

class RulingsInfoViewController: UIViewController {

    @IBOutlet weak var rulingsView: UITextView!
    var cardDataSource: CardDataSource?
    
    var isSet = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
        
    }
    
    func updateUI(){
        if !isSet{
            if let card = cardDataSource?.card, let rulings = card.rulings{
                for index in rulings.indices{
                    rulingsView.text.append("\(rulings[index].key): \(rulings[index].value)\n")
                }
                isSet = true
            }
//            rulingsView.scrollRangeToVisible(NSMakeRange(0, 0))
//            rulingsView.setContentOffset(CGPoint.zero, animated: true)
        }
    }
    
    override func viewDidLayoutSubviews() {
        rulingsView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
