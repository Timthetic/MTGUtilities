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

    /**
     Adds a uniqueCard to a set in the database and links it to a set.  Adds the set if it doesn't exist.
     
     - Parameter jsonCard: The uniqueCard to be associated with the set
     - Parameter card: The set to be associated with the uniqueCard
     - Parameter context: The database context
     
     - Note: A `UniqueCard` and a `Card` are different.  A `Card` contains data nonspecific to any given printing of that card, while a `UniqueCard` contains printing-specific information like the multiverse id, flavor text, and set.
     */
    class func createUniqueCard(jsonCard: JsonCard, forCard card: Card, inContext context: NSManagedObjectContext){
        //Try to find duplicate
        if jsonCard.identifiers.multiverseId == nil{
            print("ERROR: Nil mvId: Could not add unique card")
            return
        }
        let duplicateCard = card.printings?.filter({return $0.multiverseId == jsonCard.identifiers.multiverseId}).first
        if duplicateCard != nil{
            print("Unique card already added")
            return
        }
        
        //Add unique card
        if let newUniqueCard = NSEntityDescription.insertNewObject(forEntityName: "UniqueCard", into: context) as? UniqueCard{
            newUniqueCard.flavor = jsonCard.flavor
            newUniqueCard.multiverseId = jsonCard.identifiers.multiverseId
            newUniqueCard.number = jsonCard.number
            newUniqueCard.rarity = jsonCard.rarity
            
            newUniqueCard.baseCard = card
            print("Added Unique MID \(newUniqueCard.multiverseId) to card \(card.name ?? "NO NAME")")
            linkToSet(uniqueCard: newUniqueCard, jsonCard: jsonCard, withContext: context)
        }
        else{
            print("Failed to insert unique card")
        }
    }
    
    /**
     Adds a uniqueCard to a set in the database.  Creates the set if it doesn't exist in the database.
     
     - Parameter uniqueCard: The uniqueCard to be associated with the set
     - Parameter jsonCard: The json representation of the card (contains the set information)
     - Parameter context: The database context
     */
    private class func linkToSet(uniqueCard: UniqueCard, jsonCard: JsonCard, withContext context: NSManagedObjectContext){
        let request = NSFetchRequest<CardSet>(entityName: "CardSet")
        let predicate = NSPredicate(format: "code = %@", jsonCard.setCode!)
        request.predicate = predicate
        
        if let fetchSet = (try? context.fetch(request))?.first{
            fetchSet.addToCards(uniqueCard)
            print("Added \(uniqueCard.baseCard?.name ?? "NO NAME") to \(fetchSet.name ?? "NO NAME")")
        } else {
            if let newSet = NSEntityDescription.insertNewObject(forEntityName: "CardSet", into: context) as? CardSet{
                newSet.name = jsonCard.setName
                newSet.code = jsonCard.setCode
                newSet.addToCards(uniqueCard)
                print("Created set \(newSet.name ?? "") for \(uniqueCard.baseCard?.name ?? "NO NME")")
            }
            else{
                print("Failed to create set for card")
            }
        }
    }
}


