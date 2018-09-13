//
//  DeckDocument.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/13/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import Foundation
import UIKit


class DeckDocument: UIDocument{
    //MARK: Model
    var deck: Deck?
    
    override func contents(forType typeName: String) throws -> Any {
        return deck?.json ?? Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        if let json = contents as? Data{
            deck = Deck(json: json)
        }
    }
    
}
