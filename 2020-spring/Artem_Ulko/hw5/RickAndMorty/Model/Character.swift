//
//  Character.swift
//  RickAndMorty
//
//  Created by user on 22.04.2020.
//  Copyright © 2020 ulkoart. All rights reserved.
//
import DeepDiff
import Foundation

struct Info: Decodable {
    let next: String
}

struct Page<T: Decodable>: Decodable {
    let results: [T]
    let info: Info
}

struct Character: Decodable {
    let id: Int
    let name: String
    let image: String
    let status: String
}

extension Character: DiffAware {
  var diffId: Int {
    id
  }

  static func compareContent(_ first: Character, _ second: Character) -> Bool {
    first.id == second.id
  }
}
