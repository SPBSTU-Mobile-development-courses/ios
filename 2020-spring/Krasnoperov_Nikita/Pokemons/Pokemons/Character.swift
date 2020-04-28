//
//  Character.swift
//  homework_2
//
//  Created by Никита on 09/03/2020.
//  Copyright © 2020 Никита. All rights reserved.
//

struct Page<T: Decodable>: Decodable {
    let next: String
    let results: [T]
}

struct Character: Decodable {
    let name: String
    let url: String
}

struct CharacterDescription: Decodable {
    struct Sprites: Decodable {
        let front_default: String
        let back_default: String
    }

    let sprites: Sprites
    let weight: Int
}
