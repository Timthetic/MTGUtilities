//
//  DeckCard+CoreDataProperties.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/28/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//
//

import Foundation
import CoreData


extension DeckCard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DeckCard> {
        return NSFetchRequest<DeckCard>(entityName: "DeckCard")
    }

    @NSManaged public var quantity: Int64
    @NSManaged public var name: String
    @NSManaged public var setCode: String
    @NSManaged public var multiverseId: String
    
    @NSManaged public var uniqueCard: UniqueCard?
    @NSManaged public var baseCard: Card?
    @NSManaged public var decks: Set<Deck>?

}
