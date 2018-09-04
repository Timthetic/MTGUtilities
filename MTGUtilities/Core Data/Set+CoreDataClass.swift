//
//  Set+CoreDataClass.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/4/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Set)

public class Set: NSManagedObject {
    
    /**
     Adds a uniqueCard to a set in the database.  Saves the uniqueCard or Set if they don't exist in the database.
     
     - parameter uniqueCard: The uniqueCard to be associated with the set
     - parameter set: The set to be associated with the uniqueCard
     - parameter context: The database parameter
     */
    class func linkToSet(uniqueCard: UniqueCard, jsonCard: JsonCard, withContext context: NSManagedObjectContext){
        let request = NSFetchRequest<Set>(entityName: "Set")
        let predicate = NSPredicate(format: "code = %@", jsonCard.setCode!)
        request.predicate = predicate
        
        if let fetchSet = (try? context.fetch(request))?.first{
            fetchSet.addToCards(uniqueCard)
            print("Added \(uniqueCard.baseCard?.name ?? "NO NAME") to \(fetchSet.name ?? "NO NAME")")
        } else {
            if let newSet = NSEntityDescription.insertNewObject(forEntityName: "Set", into: context) as? Set{
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
