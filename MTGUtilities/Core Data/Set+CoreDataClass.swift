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
     - parameter context: The database context
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
    
    /**
     Adds a set to the database if it doesn't already exist.
     
     - parameter name: Name of the set
     - parameter code: The code for the set
     - parameter context: The database context
     */
    class func addSet(name: String, code: String, intoContext context: NSManagedObjectContext){
        let request = NSFetchRequest<Set>(entityName: "Set")
        let predicate = NSPredicate(format: "code = %@", code)
        request.predicate = predicate
        
        if let _ = (try? context.fetch(request))?.first{
            
        }
        else{
            if let newSet = NSEntityDescription.insertNewObject(forEntityName: "Set", into: context) as? Set{
                newSet.name = name
                newSet.code = code
                print("Created new set \(newSet.name ?? "NO NAME")")
            }
            else{
                print("Failed to create set")
            }
        }
        
    }
    
}
