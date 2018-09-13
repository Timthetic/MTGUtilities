//
//  Deck.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/13/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import Foundation

struct Deck: Codable{
    var name: String
    var cards: [dCard] = []
    var colorIdentity: [String] = []
    
    struct dCard: Codable{
        var name: String
        var setCode: String
        var mID: Int
        
        var quantity: Int
    }
    
    init?(json: Data) // take some JSON and try to init an EmojiArt from it
    {
        if let newValue = try? JSONDecoder().decode(Deck.self, from: json) {
            self = newValue
        } else {
            return nil
        }
    }
    
    var json: Data? // return this EmojiArt as a JSON data
    {
        return try? JSONEncoder().encode(self)
    }
}
