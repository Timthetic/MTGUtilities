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

    @NSManaged public var multiverseId: Int64
    @NSManaged public var number: String?
    @NSManaged public var rarity: String?
    @NSManaged public var flavor: String?
    @NSManaged public var set: Set?
    @NSManaged public var baseCard: Card?

    
}
