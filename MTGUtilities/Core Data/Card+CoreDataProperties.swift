//
//  Card+CoreDataProperties.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/2/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var colorIdentity: NSObject?
    @NSManaged public var colors: NSObject?
    @NSManaged public var loyalty: Int64
    @NSManaged public var manaCost: String?
    @NSManaged public var multiverseId: Int64
    @NSManaged public var name: String?
    @NSManaged public var number: String?
    @NSManaged public var power: String?
    @NSManaged public var rarity: String?
    @NSManaged public var rulings: NSObject?
    @NSManaged public var subtypes: String?
    @NSManaged public var text: String?
    @NSManaged public var toughness: String?
    @NSManaged public var types: String?
    @NSManaged public var cmc: Int64

}
