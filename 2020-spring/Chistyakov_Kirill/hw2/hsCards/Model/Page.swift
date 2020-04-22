//
//  Pge.swift
//  hsCards
//
//  Created by Kirill Chistyakov on 19.03.2020.
//  Copyright © 2020 Kirill Chistyakov. All rights reserved.
//

import Foundation

struct Page<T: Decodable> {
    var cardCount: Int
    var pageCount: Int
    var page: Int
    var cards: [T]
}

// MARK: - Decodable
extension Page: Decodable {
}
