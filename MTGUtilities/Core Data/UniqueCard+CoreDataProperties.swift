//
//  UniqueCard+CoreDataProperties.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/28/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//
//

import Foundation
import CoreData


extension UniqueCard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UniqueCard> {
        return NSFetchRequest<UniqueCard>(entityName: "UniqueCard")
    }

    @NSManaged public var flavor: String?
    @NSManaged public var multiverseId: Int64
    
    ///The cards number in its set
    @NSManaged public var number: String?
    
    ///A cards rarity
    @NSManaged public var rarity: String?
    @NSManaged public var baseCard: Card?
    
    @NSManaged public var set: CardSet?
    @NSManaged public var decksCards: Set<DeckCard>?

}
