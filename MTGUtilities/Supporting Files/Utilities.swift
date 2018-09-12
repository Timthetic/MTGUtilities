//
//  Utilities.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/5/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import Foundation
import UIKit

/**
 Returns an array of strings each representing on mana symbol
 - Parameter manaCost: The string you wish to parse
 - Returns: An array of strings each representing on mana symbol
 - Example: ['g', 'b'] would be returned for something that costs one green and one blue.
 */
func parse(manaCost: String)->[String]{
    var add = ""
    var parsedCost = [String]()
    for char in manaCost{
        switch char{
        case "{":
            break
        case "/":
            break
        case "}":
            parsedCost.append(add)
            add = ""
        default:
            add.append(char)
        }
    }
    return parsedCost
}

/*
 let string = NSMutableAttributedString(string: "St")
 let image1Attachment = NSTextAttachment()
 image1Attachment.image = #imageLiteral(resourceName: "R")
 image1Attachment.bounds = CGRect(x: 0, y: -5, width: 25, height: 25)
 let image1String = NSAttributedString(attachment: image1Attachment)
 string.append(image1String)
 string.append(NSAttributedString(string: "End"))
 powerToughnessLabel.attributedText = string
 */


func stringWithManaSymbols(fromString string: String, withFont font: UIFont) -> NSMutableAttributedString{
    //No mana cost symbols have nested {}, so I won't account for them.
    let attributedString = NSMutableAttributedString(string: "", attributes: [.font : font])
    var it = string.startIndex
    var start: String.Index?
//    var read = string.startIndex
    while it != string.endIndex
    {
        let char = string[it]
        switch char{
        case "{":
            attributedString.append(NSAttributedString(string: String(string[(start ?? string.startIndex)..<it]), attributes: [.font : font]))
            
            start = it
        case "}":
            if start == nil{break}
            let parsedCost = parse(manaCost: String(string[start!...it])).compactMap({$0}).joined()
            let image = UIImage(named: "\(parsedCost).png")
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = image
            imageAttachment.bounds = CGRect(x: 0, y: -5, width: 25, height: 25)
            let imageString = NSAttributedString(attachment: imageAttachment)
            attributedString.append(imageString)
            
            start = string.index(after: it)
        default:
            break
        }
        it = string.index(after: it)
    }
    attributedString.append(NSAttributedString(string: String(string[((start ?? string.startIndex) ..< string.endIndex)]), attributes: [.font : font]))

    return attributedString
    
}

/**
 Returns the `UIColor` for each mana color (green for 'G', blue for 'U'...)
 - Parameter string: One of the folowing: "W", "U", "G", "R", "B"
 - Returns: a `UIColor` for either white, blue, green, red, or black
 */
func strToColor(_ string: String) -> UIColor?{
    if let index = CONSTS.colorSymbols.index(of: string), CONSTS.colors.indices.contains(index){
        return CONSTS.colors[index]
    }
    return nil
}

extension Dictionary{
    init?(_ a: [Key]?, _ b: [Value]?) {
        self.init()
        if let a = a, let b = b{
            let k = Swift.min(a.count, b.count)
            for i in 0..<k{
                self[a[i]] = b[i]
            }
        }
    }
}

//Credit to Mike Woelmer: https://spin.atomicobject.com/2018/02/02/swift-scaled-font-bold-italic/
extension UIFont {
    func withTraits(traits:UIFontDescriptorSymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0) //size 0 means keep the size as it is
    }
    
    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }
    
    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }
}



