//
//  Utilities.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/5/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import Foundation
import UIKit

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

func strToColor(_ string: String) -> UIColor?{
    if let index = Consts.colorSymbols.index(of: string), Consts.colors.indices.contains(index){
        return Consts.colors[index]
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

