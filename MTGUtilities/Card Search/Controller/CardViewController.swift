//
//  CardViewController.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/5/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    var uniqueCard: UniqueCard?
    var card: Card!{
        didSet{
            uniqueCard = card.printings?.anyObject() as? UniqueCard
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var manaStack: UIStackView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if card == nil{
            return
        }
        DispatchQueue.global(qos: .userInitiated).async{[weak self] in
            if let mid = self?.uniqueCard?.multiverseId, let url = URL(string: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=\(mid)&type=card"){
                DispatchQueue.main.async {
                    do{
                        let data = try Data(contentsOf: url)
                        self?.imageView.image = UIImage(data: data)
                    } catch{
                        self?.imageView.image = #imageLiteral(resourceName: "back")
                    }
                }
            }
        }
        
        nameLabel.text = card.name
        typeLabel.text = "Type: \(card.type)"
        let manaCost = parse(manaCost: card.manaCost ?? "")
        for symbol in manaCost.reversed(){
            let width = min(self.view.frame.width / 12, manaStack.frame.width / CGFloat(manaCost.count))
            let imageView = UIImageView(image: UIImage(named: "\(symbol).png") ?? #imageLiteral(resourceName: "0"))
            imageView.contentMode = .scaleAspectFit
            imageView.widthAnchor.constraint(equalToConstant: width).isActive = true
            manaStack.insertArrangedSubview(imageView, at: 0)
        }
        
        textView.text = card.text ?? ""
        
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
