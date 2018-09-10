//
//  CardViewController.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/5/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit

class CardViewController: UIViewController, CardDataSource{
    var uniqueCard: UniqueCard?{
        didSet{
            if isViewLoaded{
                configureDisplay(forCard: card, andUniqueCard: uniqueCard)
            }
        }
    }
    var card: Card?{
        didSet{
            uniqueCard = card?.printings?.anyObject() as? UniqueCard
        }
    }
    @IBOutlet weak var manaLabel: UILabel!
//    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
//    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var numberView: ConvertedManaCostView!
    @IBOutlet weak var powerToughnessTitle: UILabel!
    @IBOutlet weak var powerToughnessLabel: UILabel!
    
    let colors: [UIColor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureDisplay(forCard: card, andUniqueCard: uniqueCard)
//        textView.text = card.text ?? ""
        
        // Do any additional setup after loading the view.
    }
    
    func configureDisplay(forCard card: Card?, andUniqueCard uniqueCard: UniqueCard?){
        guard let card = card, let uniqueCard = uniqueCard else{
            return
        }
        
        title = card.name
        numberView.value = Int(card.cmc)
        numberView.color = strToColor(card.colorIdentity?.first ?? "") ?? UIColor.black
        
        
        //Checks if card has power, toughness, or loyalty.  Hides those lables if it doesn't.
        if let power = card.power, let toughness = card.toughness{
            powerToughnessTitle.text = "Power / Toughness"
            powerToughnessLabel.text = "\(power) / \(toughness)"
            powerToughnessTitle.isHidden = false
            powerToughnessLabel.isHidden = false
        }
        else if card.loyalty != -1{
            let loyalty = card.loyalty
            powerToughnessTitle.text = "Loyalty"
            powerToughnessLabel.text = "\(loyalty)"
            powerToughnessTitle.isHidden = false
            powerToughnessLabel.isHidden = false
        }
        else{
            powerToughnessTitle.isHidden = true
            powerToughnessLabel.isHidden = true
        }

        
        //Fetches the card image
        DispatchQueue.global(qos: .userInitiated).async{[weak self] in
            let mid = uniqueCard.multiverseId
            if let url = URL(string: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=\(mid)&type=card"){
                do{
                    let data = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self?.imageView.image = UIImage(data: data)
                    }
                    
                } catch{
                    DispatchQueue.main.async {
                        self?.imageView.image = #imageLiteral(resourceName: "back")
                    }
                }
            }
        }
        
        //Displayes the mana cost
//        let manaCost = parse(manaCost: card.manaCost ?? "")
//        manaStack.arrangedSubviews.forEach({manaStack.removeArrangedSubview($0)})
//        for symbol in manaCost.reversed(){
//            let width = min(self.view.frame.width / 12, manaStack.frame.width / CGFloat(manaCost.count))
//            let imageView = UIImageView(image: UIImage(named: "\(symbol).png") ?? #imageLiteral(resourceName: "0"))
//            imageView.contentMode = .scaleAspectFit
//            imageView.widthAnchor.constraint(equalToConstant: width).isActive = true
//            manaStack.insertArrangedSubview(imageView, at: 0)
//        }
        manaLabel.attributedText = stringWithManaSymbols(fromString: card.manaCost ?? "", withFont: MyFont.bodyFont)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Embed Card Info"{
            if let CIPVC = segue.destination as? CardInfoPageViewController{
                CIPVC.cardDataSource = self
            }
        }
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
