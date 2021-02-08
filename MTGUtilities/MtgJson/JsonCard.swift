//
//  JsonCard.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/2/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import Foundation

class JsonCard: Codable{
    var cmc: Int?
    var colorIdentity: [String]?
    var colors: [String]?
    var flavor: String?
    var loyalty: Int?
    var manaCost: String?
    var multiverseId: Int?
    var name: String?
    var number: String?
    var power: String?
    var printings: [String]?
    var rarity: String?
    var rulings: [Ruling]?
    var setName: String?
    var setCode: String?
    var subtypes: [String]?
    var text: String?
    var toughness: String?
    var type: String?
    var types: [String]?
    
    enum CodingKeys: String, CodingKey {
        case cmc = "convertedManaCost"
        case colorIdentity = "colorIdentity"
        case colors = "colors"
        case flavor = "flavor"
        case loyalty = "loyalty"
        case manaCost = "manaCost"
        case multiverseId = "multiverseId" //
        case name = "name"
        case number = "number"
        case power = "power"
        case printings = "printings"
        case rarity = "rarity"
        case rulings = "rulings"
        case subtypes = "subtypes"
        case text = "text"
        case toughness = "toughness"
        case type = "type"
        case types = "types"
    }
}

public struct Ruling: Codable{
    var date: String
    var text: String
}

/*
 {
 "artist": "Andrea Radeck",
 "cmc": 1,
 "colorIdentity": [
 "W"
 ],
 "colors": [
 "White"
 ],
 "id": "95ebdf85f4ea74d584dfdfb72e3de5001d0748a9",
 "imageName": "adorable kitten",
 "layout": "normal",
 "manaCost": "{W}",
 "multiverseid": 439390,
 "name": "Adorable Kitten",
 "number": "1",
 "originalText": "When this creature enters the battlefield, roll a six-sided die. You gain life equal to the result.",
 "originalType": "Host Creature — Cat",
 "power": "1",
 "printings": [
 "UST"
 ],
 "rarity": "Common",
 "rulings": [
 {
 "date": "2018-01-19",
 "text": "Host creatures each have an ability that triggers when it enters the battlefield. It functions like any other creature."
 }
 ],
 "subtypes": [
 "Cat"
 ],
 "text": "When this creature enters the battlefield, roll a six-sided die. You gain life equal to the result.",
 "toughness": "1",
 "type": "Host Creature — Cat",
 "types": [
 "Host",
 "Creature"
 ]
 }
 */
