//
//  Deck+CoreDataClass.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/13/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Deck)
public class Deck: NSManagedObject {
    class func addDeck(withName name: String = "New Deck", intoContext context: NSManagedObjectContext) -> Deck?{
        if let newDeck = NSEntityDescription.insertNewObject(forEntityName: "Deck", into: context) as? Deck{
            newDeck.name = uniqueName(fromName: name, fromContext: context)
            return newDeck
        }
        return nil
    }
    
    private class func uniqueName(fromName name: String, fromContext context: NSManagedObjectContext) -> String{
        let request = NSFetchRequest<Deck>(entityName: "Deck")
        let predicate = NSPredicate(format: "name BEGINSWITH %@", name)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        request.predicate = predicate
        
        var newName: String?
        context.performAndWait {
            let similarlyNamedDecks = (try? context.fetch(request)) ?? []
            
            if similarlyNamedDecks.first?.name != name{
                newName = name
            }
            
            var suffix = 1
            while newName == nil{
                if !(similarlyNamedDecks.contains(where: {$0.name == "\(name) \(suffix)"})){
                    newName = "\(name) \(suffix)"
                }
                suffix += 1
            }
        }
        
        return newName!  //This should never be nil
    }
}
