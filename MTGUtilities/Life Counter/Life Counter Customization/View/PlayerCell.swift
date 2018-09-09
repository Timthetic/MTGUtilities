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
    //var colors: [UIColor] = [#colorLiteral(red: 1, green: 0.4980392157, blue: 0.4980392157, alpha: 1), #colorLiteral(red: 0.1987847222, green: 0.6275741676, blue: 1, alpha: 1), #colorLiteral(red: 0.3803710938, green: 0.7441134983, blue: 0.387199372, alpha: 1), #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 0.6853222018, alpha: 1)]
    var colors: [UIColor] = [UIColor.red.withAlphaComponent(0.5),
                             #colorLiteral(red: 0, green: 0.6274509804, blue: 0, alpha: 1).withAlphaComponent(0.5),
                             #colorLiteral(red: 0, green: 0.1960784314, blue: 1, alpha: 1).withAlphaComponent(0.5),
                             UIColor.black.withAlphaComponent(0.5),
                             UIColor.yellow.withAlphaComponent(0.15)]
    var selectedColorIndex = 0
    
    //MARK: - Outlets
    @IBOutlet weak var playerNameField: UITextField!{
        didSet{
            playerNameField.delegate = self
            playerNameField.autocapitalizationType = .words
        }
    }
    @IBOutlet weak var colorCollectionView: UICollectionView!{
        didSet{
            colorCollectionView.delegate = self
            colorCollectionView.dataSource = self
        }
    }
    
    //MARK: - CollectionView Delegate/DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Color Cell", for: indexPath) as? ColorCell{
            //Puts the right color in each cell
            cell.imageView.backgroundColor = colors[indexPath.item]
            //Puts a check on selected color
            if selectedColorIndex == indexPath.item{
                cell.imageView.image = #imageLiteral(resourceName: "check")
                collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ColorCell{
            cell.imageView.image = #imageLiteral(resourceName: "check")
            delegate?.colorDidChange(to: colors[indexPath.item], forPlayerCell: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ColorCell{
            cell.imageView.image = nil
        }
    }
    
    /**
     Looks for color in colors array.  If it's there, it selects that color.
     - Parameter color: The color to search for in the colors array.
     */
    func trySelect(color: UIColor){
        if let index = colors.index(of: color){
            selectedColorIndex = index
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - TextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.nameDidChange(to: playerNameField.text ?? "", forPlayerCell: self)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
    }

}

//MARK: -
protocol PlayerCellDelegate {
    func nameDidChange(to name: String, forPlayerCell playerCell: PlayerCell)
    func colorDidChange(to color: UIColor, forPlayerCell playerCell: PlayerCell)
}
