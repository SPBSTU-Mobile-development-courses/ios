//
//  Creditor.swift
//  StarWarsWiki
//
//  Created by Виталий on 11.03.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

public struct CreditsResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case cast
    }
    let cast: [Actor]
}

public struct Actor: Decodable {
    var character: String?
    var name: String?
    enum CodingKeys: String, CodingKey {
        case character, name
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.name = try? container.decode(String.self, forKey: .name)
        self.character = try? container.decode(String.self, forKey: .character)
    }
}
