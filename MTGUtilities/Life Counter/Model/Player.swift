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
    private var interactionsToCommit: [PlayerInteraction] = []
    private(set) var interactionsFromOthers: [PlayerInteraction] = []
    private(set) var interactionsToOthers: [PlayerInteraction] = []
    
    //MARK: Interaction
    func changeLife(by amount: Int, from player: Player) {
        life += amount
//        interactionsFromOthers.append(PlayerInteraction(lifeChange: amount, to: self, from: player))
//        player.interactionsToOthers.append(PlayerInteraction(lifeChange: amount, to: player, from: self))
        let interaction = getInteraction(to: self, from: player)
        interaction.changeInLife! += amount
    }
    
    func getInteraction(to target: Player, from actor: Player) -> PlayerInteraction
    {
        var addToList = true
        var interaction = PlayerInteraction(lifeChange: 0, to: target, from: actor)
        for inter in interactionsToCommit{
            if inter.actor == interaction.actor && inter.target == interaction.target{
                interaction = inter
                addToList = false
            }
        }
        if addToList{
            interactionsToCommit.append(interaction)
        }
        return interaction
    }
    
    func commitInteractions(){
        for interaction in interactionsToCommit{
            interactionsFromOthers.append(interaction.opposite)
            interactionsToOthers.append(interaction)
        }
        interactionsToCommit.removeAll()
    }
    
    func printInteractions(){
        for interaction in interactionsToOthers{
            print("\(interaction.actor!.name) did \(-1*interaction.changeInLife!) damage to \(interaction.target!.name)")
        }
        print("")
    }
    
    //MARK: Init
    init(name: String, life: Int){
        id = Player.idGenerator
        Player.idGenerator += 1
        self.name = name
        self.life = life
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

