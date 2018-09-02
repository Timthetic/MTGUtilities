//
//  Card+CoreDataClass.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/2/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//
//

import Foundation
import CoreData


public class Card: NSManagedObject {
    //TODO: Turn json object into Card
    func insertCardFrom(jsonCard: JsonCard, inManagedObjectContext context: NSManagedObjectContext){
        if jsonCard.multiverseId == nil{
            print("Could not insert into database for nil multiverse id")
            return
        }
        
        let request = NSFetchRequest<Card>(entityName: "Card")
        request.predicate = NSPredicate(format: "multiverseId = %@", jsonCard.multiverseId!)
        
        if let card: Card = (try? context.fetch(request))?.first {
            print("\(card.name ?? "???") is already in the database or we couldn't insert it.")
        }
        else{
            if let newCard = NSEntityDescription.insertNewObject(forEntityName: "Card", into: context) as? Card{
                newCard.cmc = Int64(jsonCard.cmc ?? -1)
                newCard.colorIdentity = jsonCard.colorIdentity as NSObject?
                newCard.colors = jsonCard.colors as NSObject?
                newCard.loyalty = Int64(jsonCard.loyalty ?? -1)
                newCard.manaCost = jsonCard.manaCost
                newCard.multiverseId = Int64(jsonCard.multiverseId ?? -1)
                newCard.name = jsonCard.name
                newCard.number = jsonCard.number
                newCard.power = jsonCard.power
                newCard.rarity = jsonCard.rarity
                newCard.rulings = jsonCard.rulings as NSObject?
                newCard.subtypes = jsonCard.subtypes?.compactMap({$0}).joined()
                newCard.text = jsonCard.text
                newCard.toughness = jsonCard.toughness
                newCard.types = jsonCard.types?.compactMap({$0}).joined()
                
            }
        }
        
    }
    
}
