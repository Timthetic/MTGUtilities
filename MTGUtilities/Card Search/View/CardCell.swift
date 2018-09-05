//
//  CardCell.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/5/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var manaStack: UIStackView!
    @IBOutlet weak var viewSpecificallyToBeFatAndTakeUpSpace: UIView!
    
    var imageViews = [UIImageView]()
    
    func configureCell(forCard card: Card) {
        nameLabel.text = card.name
        
        let manaCost = parse(manaCost: card.manaCost ?? "")
        for image in imageViews{
            image.removeFromSuperview()
        }
        for symbol in manaCost{
            let width = min(self.frame.width / 12, manaStack.frame.width / CGFloat(manaCost.count))
            let imageView = UIImageView(image: UIImage(named: "\(symbol).png") ?? #imageLiteral(resourceName: "0"))
            imageView.contentMode = .scaleAspectFit
            imageView.widthAnchor.constraint(equalToConstant: width).isActive = true
            manaStack.addArrangedSubview(imageView)
            imageViews.append(imageView)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
