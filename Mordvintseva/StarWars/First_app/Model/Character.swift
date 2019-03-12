//
//  Character.swift
//  First_app
//
//  Created by Mordvintseva Alena on 10/03/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

//import Foundation

struct Character: Decodable {
    let name: String
    let height: String
    let mass: String
    let hair_color: String
    let skin_color: String
    let eye_color: String
    let birth_year: String
    let gender: String
    let homeworld: String
    let films: [String]
    let species: [String]
    let vehicles: [String]
    let starships: [String]
    let created: String
    let edited: String
    let url: String

    init() {
        name = ""
        height = ""
        mass = ""
        hair_color = ""
        skin_color  = ""
        eye_color = ""
        birth_year = ""
        gender = ""
        homeworld = ""
        films = []
        species = []
        vehicles = []
        starships = []
        created = ""
        edited = ""
        url = ""
    }
}
