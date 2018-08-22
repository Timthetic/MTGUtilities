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
    private var playerTurn = 0
    
    var activePlayer: Player{
        return players[playerTurn]
    }
    
    func passTurn(){
        playerTurn += 1
        if(playerTurn >= players.count){
            playerTurn = 0
        }
    }
    
    func giveTurnTo(player: Player){
        players.swapAt(playerTurn, players.index(of: player)!)
    }
    
}
