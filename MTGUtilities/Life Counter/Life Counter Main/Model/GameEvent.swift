//
//  GameEvent.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 8/27/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import Foundation

enum GameEvent {
    case PlayerInteraction(PlayerInteraction)
    case TurnChange(Int)
}


class PlayerInteraction{
    
    weak var actor: Player?
    weak var target: Player?
    var changeInLife: Int?
    var opposite: PlayerInteraction{
        return PlayerInteraction(lifeChange: changeInLife, to: actor, from: target)
    }
    
    init(lifeChange: Int?, to target: Player?, from actor: Player?){
        changeInLife = lifeChange
        self.target = target
        self.actor = actor
    }
    
}
