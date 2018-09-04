//
//  UniqueCard+CoreDataClass.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/4/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//
//

import Foundation
import CoreData

@objc(UniqueCard)
public class UniqueCard: NSManagedObject {


    class func createUniqueCard(jsonCard: JsonCard, forCard card: Card, inContext context: NSManagedObjectContext){
        //Try to find duplicate
        if jsonCard.multiverseId == nil{
            print("Nil mvId: Could not add unique card")
            return
        }
        let predicate = NSPredicate(format: "multiverseId = %d", jsonCard.multiverseId!)
        let duplicateCard = card.printings?.filtered(using: predicate).first
        if duplicateCard != nil{
            print("Unique card already added")
            return
        }
        
        //Add unique card
        if let newUniqueCard = NSEntityDescription.insertNewObject(forEntityName: "UniqueCard", into: context) as? UniqueCard{
            newUniqueCard.flavor = jsonCard.flavor
            newUniqueCard.multiverseId = Int64(jsonCard.multiverseId!)
            newUniqueCard.number = jsonCard.number
            newUniqueCard.rarity = jsonCard.rarity
            
            newUniqueCard.baseCard = card
            print("Added Unique MID \(newUniqueCard.multiverseId) to card \(card.name ?? "NO NAME")")
            Set.linkToSet(uniqueCard: newUniqueCard, jsonCard: jsonCard, withContext: context)
        }
    }
}


