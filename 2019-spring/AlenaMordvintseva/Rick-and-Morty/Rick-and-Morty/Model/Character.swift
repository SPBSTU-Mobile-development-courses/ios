//
//  Character.swift
//  Rick-and-Morty
//
//  Created by Mordvintseva Alena on 17/03/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import Foundation
import RealmSwift

struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
