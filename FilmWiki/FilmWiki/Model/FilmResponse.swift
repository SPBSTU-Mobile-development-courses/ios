//
//  FilmResponse.swift
//  FIlmWiki
//
//  Created by Мария on 13/03/2019.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

public struct  FilmResponse: Decodable {
    let results: [Film]
}
