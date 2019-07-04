//
//  Word.swift
//  Dictionary
//
//  Created by Мария on 21/03/2019.
//  Copyright © 2019 Мария. All rights reserved.
//

import Foundation

struct Word: Decodable {
    let title: String
    let lexicalEntries: [LexicalEntry]?
    
    enum CodingKeys: String, CodingKey {
        case lexicalEntries, title = "word"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title).lowercased()
        lexicalEntries = try? container.decode([LexicalEntry].self, forKey: .lexicalEntries)
    }
}
