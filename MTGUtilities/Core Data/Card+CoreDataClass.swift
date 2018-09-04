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
    
    class func insertCardFrom(jsonCard: JsonCard, inManagedObjectContext context: NSManagedObjectContext){
        if jsonCard.multiverseId == nil{
            //print("Could not insert \(jsonCard.name ?? "nil name"): nil multiverse id")
            return
        }
        
        context.perform{
            var card: Card!
            let request = NSFetchRequest<Card>(entityName: "Card")
            request.predicate = NSPredicate(format: "name = %@", jsonCard.name!)
            if let fetchCard: Card = (try? context.fetch(request))?.first{
                card = fetchCard
                print("Already have \(card.name ?? "NO NAME"). Checking printings.")
            }
            else{
                if let newCard = NSEntityDescription.insertNewObject(forEntityName: "Card", into: context) as? Card{
                    
                    newCard.cmc = Int64(jsonCard.cmc ?? -1)
                    newCard.colorIdentity = jsonCard.colorIdentity
                    newCard.colors = jsonCard.colors
                    newCard.loyalty = Int64(jsonCard.loyalty ?? -1)
                    newCard.manaCost = jsonCard.manaCost
//                    newCard.multiverseId = Int64(jsonCard.multiverseId ?? -1)
                    newCard.name = jsonCard.name
//                    newCard.number = jsonCard.number
                    newCard.power = jsonCard.power
//                    newCard.rarity = jsonCard.rarity
                    newCard.rulings = Dictionary((jsonCard.rulings?.compactMap({ruling in return ruling.date})), (jsonCard.rulings?.compactMap({ruling in return ruling.text}))) //jsonCard.rulings
                    newCard.subtypes = jsonCard.subtypes?.compactMap({$0}).joined()
                    newCard.text = jsonCard.text
                    newCard.toughness = jsonCard.toughness
                    newCard.types = jsonCard.types?.compactMap({$0}).joined()
                    //print("Inserted: \(newCard.name ?? "nil name")")
                    card = newCard
                    print("Created new card \(card.name ?? "NO NAME")")
                }
                else{
                    print("An issue maybe?")
                }
            }
            
            //Add Unique Card
            UniqueCard.createUniqueCard(jsonCard: jsonCard, forCard: card, inContext: context)
        }
    }
    
}

extension Dictionary{
    init?(_ a: [Key]?, _ b: [Value]?) {
        self.init()
        if let a = a, let b = b{
            let k = Swift.min(a.count, b.count)
            for i in 0..<k{
                self[a[i]] = b[i]
            }
        }
    }
}
