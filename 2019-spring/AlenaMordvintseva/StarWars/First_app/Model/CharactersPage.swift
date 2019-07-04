//
//  CharactersLibrary.swift
//  First_app
//
//  Created by Mordvintseva Alena on 10/03/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

struct CharactersPage: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Character]
}
