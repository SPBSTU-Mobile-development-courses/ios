//
//  Creditor.swift
//  StarWarsWiki
//
//  Created by Виталий on 11.03.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

public struct Actor: Decodable {
    var character: String
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case character
        case name
    }
}
