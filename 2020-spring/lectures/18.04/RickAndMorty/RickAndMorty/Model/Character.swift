//
//  Character.swift
//  RickAndMorty
//
//  Created by Anton Nazarov on 06.03.2020.
//  Copyright © 2020 Anton Nazarov. All rights reserved.
//

import Foundation

struct Character {
    let id: Int
    let name: String
    let image: String
}

extension Character {
    var imageUrl: URL? {
        URL(string: image)
    }
}

// MARK: - Decodable
extension Character: Decodable {
}

// MARK: - Equatable
extension Character: Equatable {
}
