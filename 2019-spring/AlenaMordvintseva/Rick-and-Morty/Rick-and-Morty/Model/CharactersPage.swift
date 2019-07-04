//
//  CharactersPage.swift
//  Rick-and-Morty
//
//  Created by Mordvintseva Alena on 18/03/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import Foundation

struct CharactersPage: Decodable {
    let info: Info
    let results: [Character]
}
