//
//  Card.swift
//  hsCards
//
//  Created by Kirill Chistyakov on 17.03.2020.
//  Copyright © 2020 Kirill Chistyakov. All rights reserved.
//

import Foundation

//swiftlint:disable identifier_name
struct Card {
    let id: Int
    let name: String
    let image: String
    let flavorText: String?
    let artistName: String?
}

extension Card {
    var imageUrl: URL? {
        URL(string: image)
    }
}

// MARK: - Decodable
extension Card: Decodable {
}
