//
//  TableViewCell.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 8/26/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit

class GameHistoryCell: UITableViewCell {

    @IBOutlet weak var InfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
