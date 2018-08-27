//
//  LifeTracker.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 8/20/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import Foundation

class GameTracker {
    var players: [Player] = [] //Array order determines turn order
    var numberOfTurnsSet = 0
    
    var interactionsToCommit: [PlayerInteraction] = []
    var interactions: [PlayerInteraction] = []
    var numberOfPlayers: Int = 1
    
    private var playerTurn = 0
    
    enum GameState {
        case choosingTurnOrder
        case playing
    }
    var gameState: GameState = .choosingTurnOrder
    
    
    init(numberOfPlayers: Int, startingLife: Int) {
        self.numberOfPlayers = numberOfPlayers
        for i in 0..<numberOfPlayers {
            players.append(Player(name: "Player \(i+1)", life: startingLife))
        }
    }
    
    func setForNextTurn(player: Player) throws
    {
        let indexOfPlayer = players.index(of: player)
        if indexOfPlayer != nil{
            players.swapAt(Int(indexOfPlayer!.magnitude), numberOfTurnsSet)
            numberOfTurnsSet += 1
        } else {
            throw NSError()
            
        }
        
    }
    
    var activePlayer: Player{
        return players[playerTurn]
    }
    
    func changeLifeOf(player: Player, by amount: Int){
        player.changeLife(by: amount, from: players[playerTurn])
        let interaction = getInteraction(to: player, from: players[playerTurn])
        interaction.changeInLife! += amount
    }
    
    func passTurn(){
        playerTurn += 1
        if(playerTurn >= players.count){
            playerTurn = 0
        }
        
        for player in players{
            
            player.commitInteractions()
        }
        commitInteractions()
        printInteractions()
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
            interactions.append(interaction)
        }
        interactionsToCommit.removeAll()
    }
    
    func printInteractions(){
        for interaction in interactions{
            print("\(interaction.actor!.name) did \(-1*interaction.changeInLife!) damage to \(interaction.target!.name)")
        }
        print("")
    }
    
    func giveTurnTo(player: Player){
        players.swapAt(playerTurn, players.index(of: player)!)
    }
}


