//
//  Utilities.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/5/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import Foundation

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
