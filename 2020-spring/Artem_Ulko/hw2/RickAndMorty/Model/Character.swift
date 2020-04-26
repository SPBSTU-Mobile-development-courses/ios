//
//  Character.swift
//  RickAndMorty
//
//  Created by user on 22.04.2020.
//  Copyright © 2020 ulkoart. All rights reserved.
//
import Foundation


struct Info: Decodable {
    let next: String
}

struct Page<T: Decodable>: Decodable {
    let results: [T]
    let info: Info
}

struct Character: Decodable {
    let name: String
    let image: String
    let status: String
}
