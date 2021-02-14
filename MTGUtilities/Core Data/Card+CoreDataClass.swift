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
    ///Gives the types and subtypes in the form "type1 type2 - subtype1"
    var type: String{
        return "\(types ?? "")\(subtypes != "" && subtypes != nil ? " - " : "")\(subtypes ?? "")"
    }
    
    /**
     Use this function to add a new card to the database.  Duplicate cards will be ignored. Cards with the same name are grouped together.
     
     - Parameter jsonCard: The json representation of the card
     - Parameter context: The database context
     */
    func mostRecentPrinting() -> UniqueCard?{
        var mostRecent: UniqueCard?
        if self.printings == nil{
            print("This card has no printings!")
            return nil
        }
        for card in self.printings!{
//            if let card = card as? UniqueCard{
            if card.set?.releaseDate?.isAfter(date: mostRecent?.set?.releaseDate ?? NSDate.init(timeIntervalSince1970: 0)) ?? false{
                mostRecent = card
            }
//            }
        }
        return mostRecent
    }
    
    class func insertCardFrom(jsonCard: JsonCard, inManagedObjectContext context: NSManagedObjectContext){
        if jsonCard.identifiers.multiverseId == nil{
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
                    newCard.name = jsonCard.name
//                    newCard.number = jsonCard.number
                    newCard.power = jsonCard.power
//                    newCard.rarity = jsonCard.rarity
                    newCard.rulingDates = jsonCard.rulings?.compactMap({$0.date})
                    newCard.rulings = jsonCard.rulings?.compactMap({$0.text})
//                    print("Json: \(jsonCard.rulings?.count ?? 0)  Data: \(newCard.rulings?.count ?? 0)")
                    assert(newCard.rulings?.count ?? 0 == jsonCard.rulings?.count ?? 0)
                    newCard.subtypes = jsonCard.subtypes?.compactMap({$0}).joined(separator: " ")
                    newCard.text = jsonCard.text
                    newCard.toughness = jsonCard.toughness
                    newCard.types = jsonCard.types?.compactMap({$0}).joined(separator: " ")
                    //print("Inserted: \(newCard.name ?? "nil name")")
                    card = newCard
                    print("Created new card \(card.name ?? "NO NAME")")
                }
                else{
                    print("An issue maybe?")
                    return
                }
            }
            
            //Add Unique Card
            UniqueCard.createUniqueCard(jsonCard: jsonCard, forCard: card, inContext: context)
        }
    }
    
}
