//
//  Set+CoreDataProperties.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/17/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//
//

import Foundation
import CoreData


extension Set {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Set> {
        return NSFetchRequest<Set>(entityName: "Set")
    }

    @NSManaged public var code: String?
    @NSManaged public var name: String?
    @NSManaged public var releaseDate: NSDate?
    @NSManaged public var cards: NSSet?

}

// MARK: Generated accessors for cards
extension Set {

    @objc(addCardsObject:)
    @NSManaged public func addToCards(_ value: UniqueCard)

    @objc(removeCardsObject:)
    @NSManaged public func removeFromCards(_ value: UniqueCard)

    @objc(addCards:)
    @NSManaged public func addToCards(_ values: NSSet)

    @objc(removeCards:)
    @NSManaged public func removeFromCards(_ values: NSSet)

}
