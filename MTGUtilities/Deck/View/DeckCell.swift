//
//  DeckCell.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/13/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit

class DeckCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var colorIdLabel: UILabel!
    
    func configure(forDeck deck: Deck){
        nameLabel.text = deck.name
        var clrID = deck.colorIdentity
        if clrID?.isEmpty ?? false{
            clrID?.append("{C}")
        }
        colorIdLabel.attributedText = stringWithManaSymbols(fromString: clrID?.compactMap({$0}).joined() ?? "{C}", withFont: MyFont.bodyFont)
    }
}
