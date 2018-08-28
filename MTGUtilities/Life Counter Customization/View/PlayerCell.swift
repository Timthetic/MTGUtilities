//
//  PlayerCell.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 8/28/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var delegate: PlayerCellDelegate?
    var colors: [UIColor] = [#colorLiteral(red: 1, green: 0.4980392157, blue: 0.4980392157, alpha: 1), #colorLiteral(red: 0.1987847222, green: 0.6275741676, blue: 1, alpha: 1), #colorLiteral(red: 0.3803710938, green: 0.7441134983, blue: 0.387199372, alpha: 1), #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 0.6853222018, alpha: 1)]
    
    @IBOutlet weak var playerNameField: UITextField!{
        didSet{
            playerNameField.delegate = self
        }
    }
    @IBOutlet weak var colorCollectionView: UICollectionView!{
        didSet{
            colorCollectionView.delegate = self
            colorCollectionView.dataSource = self
        }
    }
    
    //MARK: CollectionView Delegate/DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //FIXME: HERE
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Color Cell", for: indexPath) as? ColorCell{
            cell.imageView.backgroundColor = colors[indexPath.item]
            return cell
        }
        return UICollectionViewCell()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.nameDidChange(to: textField.text ?? "", forPlayerCell: self)
    }

}

protocol PlayerCellDelegate {
    func nameDidChange(to name: String, forPlayerCell playerCell: PlayerCell)
}
