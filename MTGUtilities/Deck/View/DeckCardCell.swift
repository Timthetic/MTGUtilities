//
//  DeckCardCell.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/18/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit

class DeckCardCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
