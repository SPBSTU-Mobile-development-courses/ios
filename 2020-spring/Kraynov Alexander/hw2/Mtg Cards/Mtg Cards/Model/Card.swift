//
//  Card.swift
//  Mtg Cards
//
//  Created by alexander on 07.03.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import DeepDiff
import Foundation

struct Card: Decodable, DiffAware {
    typealias DiffId = String
    struct CardFaceImages: Decodable {
        let normal: String?
    }

    var diffId: DiffId { id }

    let id: String
    let name: String
    let artist: String?
    let rarity: String
    let flavorText: String?
    let imageUris: CardFaceImages?

    static func compareContent(_ first: Card, _ second: Card) -> Bool {
        first.id == second.id
    }
}
