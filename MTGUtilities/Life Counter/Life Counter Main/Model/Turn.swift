//
//  Turn.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 12/26/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import Foundation

class Turn {
    let owner: Player!
    let number: Int!
    var interactions: [PlayerInteraction] = []
    
    init(forPlayer owner: Player, withNumber turnNumber: Int) {
        self.owner = owner
        self.number = turnNumber
    }
    
}
