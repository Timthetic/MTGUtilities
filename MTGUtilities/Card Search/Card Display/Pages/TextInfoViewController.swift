//
//  TextInfoViewController.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/6/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit

class TextInfoViewController: UIViewController {

//    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    var cardDataSource: CardDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.isExclusiveTouch = false
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    override func touchesMoved(_ touches: Swift.Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
    }
    
    func updateUI(){
        if let card = cardDataSource?.card{
            if let uniqueCard = cardDataSource?.uniqueCard{
                
                var italicAtr: [NSAttributedString.Key: AnyObject] = [.font: MyFont.italicFont]
                var standardAtr: [NSAttributedString.Key: AnyObject] = [.font: MyFont.bodyFont]
                
                if #available(iOS 13.0, *) {
                    standardAtr[.foregroundColor] = UIColor.label
                    italicAtr[.foregroundColor] = UIColor.label
                } else {
                    // Fallback on earlier versions
                    // Nothing
                }
                
                let cardText = stringWithManaSymbols(fromString: "Type: \(card.type)\n\n\(card.text ?? "")\n\n", withAttributes: standardAtr)
                let attributedText = NSMutableAttributedString(string: "", attributes: standardAtr)
                attributedText.append(cardText)
                
                let flavorAttributedText = NSAttributedString(string: uniqueCard.flavor ?? "", attributes: italicAtr)
                

                attributedText.append(flavorAttributedText)
                
                textView.attributedText = attributedText
                //textView.setContentOffset(CGPoint.zero, animated: true)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        textView.setContentOffset(CGPoint.zero, animated: false)
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
