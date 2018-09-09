//
//  UniqueCard+CoreDataProperties.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/4/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//
//

import Foundation
import CoreData


extension UniqueCard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UniqueCard> {
        return NSFetchRequest<UniqueCard>(entityName: "UniqueCard")
    }
    ///Wizards of the Cost's unique identifier for a printing of a card
    @NSManaged public var multiverseId: Int64
    
    ///The cards number in its set
    @NSManaged public var number: String?
    
    ///A cards rarity
    @NSManaged public var rarity: String?
    
    ///Italic flavor text that may appear on a card
    @NSManaged public var flavor: String?
    
    ///The set this printing appears in
    @NSManaged public var set: Set?
    
    ///The general card not specific to this printing
    @NSManaged public var baseCard: Card?

    
}
