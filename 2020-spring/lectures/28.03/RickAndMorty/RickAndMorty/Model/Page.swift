//
//  Page.swift
//  RickAndMorty
//
//  Created by Anton Nazarov on 06.03.2020.
//  Copyright © 2020 Anton Nazarov. All rights reserved.
//

import Foundation

struct Page<T: Decodable> {
    struct Info: Decodable {
        let count: Int
        let pages: Int
        let next: String
    }

    let results: [T]
    let info: Info
}

// MARK: - Decodable
extension Page: Decodable {
}
