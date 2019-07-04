//
//  Sense.swift
//  Dictionary
//
//  Created by Мария on 24/03/2019.
//  Copyright © 2019 Мария. All rights reserved.
//

import Foundation

struct Sense: Decodable {
    let definitions: [String]?
    let shortDefinitions: [String]?
    let examples: [SenseExample]?
    
    enum CodingKeys: String, CodingKey {
        case definitions, examples, shortDefinitions = "short_definitions"
    }
}
