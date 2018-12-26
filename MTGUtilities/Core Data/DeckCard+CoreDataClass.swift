//
//  DeckCard+CoreDataClass.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/18/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//
//

import Foundation
import CoreData

@objc(DeckCard)
public class DeckCard: NSManagedObject {
    class func set(uniqueCard: UniqueCard, ofQuanity quantity: Int, forDeck deck: Deck, withContext context: NSManagedObjectContext){
        guard let baseCard = uniqueCard.baseCard else{
            preconditionFailure("I coudn't get any data for this card.")
        }
        let deckCard: DeckCard? = deck.cards?.first(where: {element in (element.multiverseId == uniqueCard.multiverseId)})
        
        if deckCard != nil{
            deckCard?.quantity = Int64(quantity)
        }
        else{
            guard let newDeckCard = NSEntityDescription.insertNewObject(forEntityName: "DeckCard", into: context) as? DeckCard else{
                preconditionFailure("")
            }
            
            newDeckCard.name = baseCard.name ?? "--Error--"
            newDeckCard.setCode = uniqueCard.set?.name ?? "--Error--"
            newDeckCard.multiverseId = uniqueCard.multiverseId
            newDeckCard.baseCard = baseCard
            newDeckCard.uniqueCard = uniqueCard
            
            newDeckCard.quantity = Int64(quantity)
        }
        
        
        
    }
}
