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
    /**
     Changes the life of a player and records the change of life for the current turn.
     - Parameters:
        - player: The player who's life is to be changes
        - amount: They ammount of life to add to the player (use negative value for damage)
     */
    func changeLifeOf(player: Player, by amount: Int){
        
        let actingPlayer = explicitActivePlayer ?? activePlayer
        
        player.changeLife(by: amount, from: actingPlayer)
        //Records the change in life.  If this is not the first time life has been changed, it just edits the previous interaction.
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
        commitEvents()
        printInteractions()
        eventsToCommit.append(GameEvent.TurnChange(turnNumber))
        
        explicitActivePlayer = nil
    }
    
    //MARK: Interactions and Events
    /**
     Returns an interaction between two players
     - Parameters:
        - target: The player affected by the life change
        - actor: The player responsible for the life change
     - Returns: The `PlayerInteraction` betweent the two players.  If one doesn't exist, this function creates one.
     - Note: This function only returns uncommited interactions (interactions for the current turn).
     */
    private func getInteraction(to target: Player, from actor: Player) -> PlayerInteraction
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
    
    /**
     Saves all events to the main container.
     */
    private func commitEvents(){
        for event in eventsToCommit{
            events.append(event)
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


