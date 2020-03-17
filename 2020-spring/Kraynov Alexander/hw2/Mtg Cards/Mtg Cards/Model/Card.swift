//
//  Card.swift
//  Mtg Cards
//
//  Created by alexander on 07.03.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import Foundation

struct Card: Decodable {
    struct CardFaceImages: Decodable {
        let normal: String?
    }

    let name: String
    let artist: String?
    let rarity: String
    let flavorText: String?
    let imageUris: CardFaceImages?
}
