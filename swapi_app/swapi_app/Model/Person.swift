//
//  Person.swift
//  swapi_app
//
//  Created by Andrew on 27/04/2019.
//  Copyright © 2019 SPbSTU. All rights reserved.
//

struct Person: Decodable {
    let name: String
    let height: String
    let mass: String
    let hairColor: String
    let skinColor: String
    let eyeColor: String
    let birthYear: String
    let gender: String
    let homeworld: String
    let films: [String]
    let species: [String]
    let vehicles: [String]
    let starships: [String]
    let created: String
    let edited: String
    let url: String
}
