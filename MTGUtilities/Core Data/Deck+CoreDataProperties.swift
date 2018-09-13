//
//  Deck+CoreDataProperties.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/13/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//
//

import Foundation
import CoreData


extension Deck {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Deck> {
        return NSFetchRequest<Deck>(entityName: "Deck")
    }

    @NSManaged public var name: String?
    @NSManaged public var colorIdentity: NSObject?
    @NSManaged public var cards: UniqueCard?

}
