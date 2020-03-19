//
//  CardPage.swift
//  Mtg Cards
//
//  Created by alexander on 07.03.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import Foundation

struct CardPage<T: Decodable>: Decodable {
    let nextPage: String
    let data: [T]
}
