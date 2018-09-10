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
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    func updateUI(){
        if let card = cardDataSource?.card{
            if let uniqueCard = cardDataSource?.uniqueCard{
                
                let cardText = stringWithManaSymbols(fromString: "Type: \(card.type)\n\n\(card.text ?? "")\n\n", withFont: MyFont.bodyFont)
                let attributedText = NSMutableAttributedString(string: "", attributes: [.font:MyFont.bodyFont])
                attributedText.append(cardText)
                
                let flavorAttributedText = NSAttributedString(string: uniqueCard.flavor ?? "", attributes: [.font: MyFont.italicFont])
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
