//
//  CardSet+CoreDataClass.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/4/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//
//

import Foundation
import CoreData

@objc(CardSet)

public class CardSet: NSManagedObject {
    

    
    /**
     Adds a set to the database if it doesn't already exist.
     
     - parameter name: Name of the set
     - parameter code: The code for the set
     - parameter context: The database context
     */
    class func addSet(name: String, code: String, date: NSDate, intoContext context: NSManagedObjectContext){
        let request = NSFetchRequest<CardSet>(entityName: "CardSet")
        let predicate = NSPredicate(format: "code = %@", code)
        request.predicate = predicate
        
        context.performAndWait {
            if let _ = (try? context.fetch(request))?.first{
                
            }
            else{
                if let newSet = NSEntityDescription.insertNewObject(forEntityName: "CardSet", into: context) as? MTGUtilities.CardSet{
                    newSet.name = name
                    newSet.code = code
                    newSet.releaseDate = date
                    print("Created new set \(newSet.name ?? "NO NAME")")
                }
                else{
                    print("Failed to create set")
                }
            }
        }
    }
    
}
