//
//  LifeTracker.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 8/20/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import Foundation

//TODO: Oh right... Nexus of Fate exists

class GameTracker {
    var players: [Player] = [] //Array order determines turn order
    var numberOfTurnsSet = 0
    var turnNumber = 1
    var eventsToCommit: [GameEvent] = [GameEvent.TurnChange(1)]
    var events: [GameEvent] = []
    var numberOfPlayers: Int = 1
    private var playerTurn = 0
    
    //MARK: Game State
    var gameState: GameState = .choosingTurnOrder
    
    enum GameState {
        case choosingTurnOrder
        case playing
    }
    
    //MARK: Init
    init(numberOfPlayers: Int, startingLife: Int) {
        self.numberOfPlayers = numberOfPlayers
        for i in 0..<numberOfPlayers {
            players.append(Player(name: "Player \(i+1)", life: startingLife))
        }
    }
    
    //MARK: Life
    func changeLifeOf(player: Player, by amount: Int){
        
        let actingPlayer = explicitActivePlayer ?? activePlayer
        
        player.changeLife(by: amount, from: actingPlayer)
        let interaction = getInteraction(to: player, from: actingPlayer)
        interaction.changeInLife! += amount
    }
    
    //MARK: Turn/"Priority" Management
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
    //If someone does damage on anothers turn
    var explicitActivePlayer: Player? = nil{
        didSet{
            //we don't need to specify the active player if it's what we expect.
            if explicitActivePlayer == activePlayer{
                explicitActivePlayer = nil
            }
        }
    }

    
    func passTurn(){
        playerTurn += 1
        turnNumber += 1
        
        if(playerTurn >= players.count){
            playerTurn = 0
        }
        for player in players{
            
            player.commitInteractions()
        }
        commitInteractions()
        printInteractions()
        eventsToCommit.append(GameEvent.TurnChange(turnNumber))
        
        explicitActivePlayer = nil
    }
    
    //MARK: Interactions and Events
    func getInteraction(to target: Player, from actor: Player) -> PlayerInteraction
    {
        var addToList = true
        var interaction = PlayerInteraction(lifeChange: 0, to: target, from: actor)
        for event in eventsToCommit{
            switch event{
            case .PlayerInteraction(let inter):
                if inter.actor == interaction.actor && inter.target == interaction.target{
                    interaction = inter
                    addToList = false
                }
            case .TurnChange:
                break
            }
        }
        if addToList{
            eventsToCommit.append(GameEvent.PlayerInteraction(interaction))
        }
        return interaction
    }
    
    func commitInteractions(){
        for interaction in eventsToCommit{
            events.append(interaction)
        }
        eventsToCommit.removeAll()
    }
    
    func printInteractions(){
        for interaction in events{
            switch interaction{
            case .PlayerInteraction(let interaction):
                print("\(interaction.actor!.name) did \(-1*interaction.changeInLife!) damage to \(interaction.target!.name)")
            case .TurnChange(let turnNumber):
                print("TURN NUMBER: \(turnNumber)")
            }
        }
        print("")
    }
    
}


