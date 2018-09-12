//
//  SwitchViewController.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/11/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit

class SwitchViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !UIAccessibilityIsReduceTransparencyEnabled(){
            let blur = UIBlurEffect(style: .regular)
            let blurView = UIVisualEffectView(effect: blur)
            blurView.frame = self.view.bounds
            blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.addSubview(blurView)
            view.isOpaque = false
            view.backgroundColor = .clear
        }
        else{
            view.isOpaque = true
            view.backgroundColor = .white
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Swift.Set<UITouch>, with event: UIEvent?) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
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
