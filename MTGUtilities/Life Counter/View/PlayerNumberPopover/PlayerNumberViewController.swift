//
//  PlayerNumberViewController.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 8/22/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit

class PlayerNumberViewController: UIViewController {

    var number = 2{
        didSet{
            playersLabel?.text = "\(number)"
        }
    }
    
    @IBOutlet weak var playersLabel: UILabel!
    
    @IBAction func StepperTapped(_ sender: UIStepper, forEvent event: UIEvent) {
        number = Int(sender.value)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
