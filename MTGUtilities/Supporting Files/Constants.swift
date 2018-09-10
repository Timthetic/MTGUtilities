//
//  Constants.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 8/24/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import Foundation
import UIKit
struct Consts {
    static let FONT_TO_HEIGHT: CGFloat = 1/12
    static let HORIZONTAL_GAP_BETWEEN_LIFEVIEWS: CGFloat = 0.1
    static let colors: [UIColor] = [UIColor.red.withAlphaComponent(0.5),
                                        #colorLiteral(red: 0, green: 0.6274509804, blue: 0, alpha: 1).withAlphaComponent(0.5),
                                        #colorLiteral(red: 0, green: 0.1960784314, blue: 1, alpha: 1).withAlphaComponent(0.5),
                                        UIColor.black.withAlphaComponent(0.5),
                                        UIColor.yellow.withAlphaComponent(0.15)]
    static let colorSymbols = ["R", "G", "U", "B", "W"]
    
}
struct MyFont{
    static let bodyFont = UIFont.preferredFont(forTextStyle: .body)
    static let italicFont = UIFont.preferredFont(forTextStyle: .body).italic()
}
