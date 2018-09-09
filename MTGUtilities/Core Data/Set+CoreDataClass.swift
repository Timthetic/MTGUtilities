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
