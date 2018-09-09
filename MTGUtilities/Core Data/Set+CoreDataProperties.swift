//
//  Set+CoreDataProperties.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/4/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//
//

import Foundation
import CoreData


extension Set {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Set> {
        return NSFetchRequest<Set>(entityName: "Set")
    }

    ///The set's full name
    @NSManaged public var name: String?
    
    ///The set's shortened code (i.e. IXN for Ixalan)
    @NSManaged public var code: String?
    
    ///All of the `UniqueCard`s that appear in the set
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
