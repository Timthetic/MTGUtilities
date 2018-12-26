//
//  Card+CoreDataProperties.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/28/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var cmc: Int64
    @NSManaged public var colorIdentity: [String]?
    @NSManaged public var colors: [String]?
    @NSManaged public var loyalty: Int64
    @NSManaged public var manaCost: String?
    @NSManaged public var name: String?
    @NSManaged public var power: String?
    @NSManaged public var rulings: [String]?
    @NSManaged public var rulingDates: [String]?
    @NSManaged public var subtypes: String?
    @NSManaged public var text: String?
    @NSManaged public var toughness: String?
    @NSManaged public var types: String?
    
    ///All the versions of this card
    @NSManaged public var printings: Set<UniqueCard>?
    @NSManaged public var deckCards: Set<DeckCard>?

}

// MARK: Generated accessors for printings
extension Card {

    @objc(addPrintingsObject:)
    @NSManaged public func addToPrintings(_ value: UniqueCard)

    @objc(removePrintingsObject:)
    @NSManaged public func removeFromPrintings(_ value: UniqueCard)

    @objc(addPrintings:)
    @NSManaged public func addToPrintings(_ values: NSSet)

    @objc(removePrintings:)
    @NSManaged public func removeFromPrintings(_ values: NSSet)

}
