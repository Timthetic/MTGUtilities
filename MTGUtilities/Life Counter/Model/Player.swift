//
//  Player.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 8/21/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import Foundation

class Player: Equatable, Hashable{
    
    var id: Int
    var name: String
    private(set) var life = 20
    private(set) var interactionsFromOthers: [PlayerInteraction] = []
    private(set) var interactionsToOthers: [PlayerInteraction] = []
    
    //MARK: Interaction
    func changeLife(by amount: Int, from player: Player) {
        life += amount
        interactionsFromOthers.append(PlayerInteraction(lifeChange: amount, to: self, from: player))
        player.interactionsToOthers.append(PlayerInteraction(lifeChange: amount, to: player, from: self))
    }
    
    //MARK: Init
    init(name: String){
        id = Player.idGenerator
        Player.idGenerator += 1
        self.name = name
    }
    
    //MARK: Equatable
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id
    }
    
    //MARK: ID and Hash Value
    static var idGenerator = 0
    
    var hashValue: Int{
        return id
    }
    
}

class PlayerInteraction{
    weak var actor: Player?
    weak var target: Player?
    var changeInLife: Int?
    
    init(lifeChange: Int, to target: Player, from actor: Player){
        changeInLife = lifeChange
        self.target = target
        self.actor = actor
    }
    
}
