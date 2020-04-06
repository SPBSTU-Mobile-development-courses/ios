//
//  Character.swift
//  RickAndMorty
//
//  Created by Nikita Pinaev on 16.03.2020.
//  Copyright © 2020 Nikita Pinaev. All rights reserved.
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

struct Character: Decodable {
    let id: Int
    let name: String
    let image: String
    let status: String
    let species: String
}

extension Character {
    var imageUrl: URL? {
        URL(string: image)
    }
}
