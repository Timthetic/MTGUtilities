//
//  CardSet+CoreDataProperties.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/18/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//
//

import Foundation
import CoreData


extension CardSet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CardSet> {
        return NSFetchRequest<CardSet>(entityName: "CardSet")
    }

    @NSManaged public var code: String?
    @NSManaged public var name: String?
    @NSManaged public var releaseDate: NSDate?
    @NSManaged public var cards: Set<UniqueCard>?

}

// MARK: Generated accessors for cards
extension CardSet {

    @objc(addCardsObject:)
    @NSManaged public func addToCards(_ value: UniqueCard)

    @objc(removeCardsObject:)
    @NSManaged public func removeFromCards(_ value: UniqueCard)

    @objc(addCards:)
    @NSManaged public func addToCards(_ values: NSSet)

    @objc(removeCards:)
    @NSManaged public func removeFromCards(_ values: NSSet)

}
