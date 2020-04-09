//
//  CardRealm.swift
//  Mtg Cards
//
//  Created by Admin on 31.03.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import Foundation
import RealmSwift

class CardRealm: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var artist: String?
    @objc dynamic var rarity: String = ""
    @objc dynamic var flavorText: String?
    @objc dynamic var normalResImage: String?
    @objc dynamic var id: String = ""

    override class func primaryKey() -> String? {
        "id"
    }
}

extension CardRealm {
    var card: Card {
        Card(id: id, name: name, artist: artist, rarity: rarity, flavorText: flavorText, imageUris: Card.CardFaceImages(normal: normalResImage))
    }

    convenience init(card: Card) {
        self.init()
        name = card.name
        artist = card.artist
        rarity = card.rarity
        flavorText = card.flavorText
        normalResImage = card.imageUris?.normal
        id = card.id
    }
}
