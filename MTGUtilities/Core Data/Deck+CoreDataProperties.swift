//
//  Deck+CoreDataProperties.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/28/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//
//

import Foundation
import CoreData


extension Deck {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Deck> {
        return NSFetchRequest<Deck>(entityName: "Deck")
    }

    @NSManaged public var colorIdentity: [String]?
    @NSManaged public var name: String?
    @NSManaged public var cards: Set<DeckCard>?

}

// MARK: Generated accessors for cards
extension Deck {

    @objc(addCardsObject:)
    @NSManaged public func addToCards(_ value: DeckCard)

    @objc(removeCardsObject:)
    @NSManaged public func removeFromCards(_ value: DeckCard)

    @objc(addCards:)
    @NSManaged public func addToCards(_ values: NSSet)

    @objc(removeCards:)
    @NSManaged public func removeFromCards(_ values: NSSet)

}
