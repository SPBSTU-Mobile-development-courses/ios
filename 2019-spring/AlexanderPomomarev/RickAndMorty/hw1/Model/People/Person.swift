//
//  Character.swift
//  hw1
//
//  Created by Александр Пономарёв on 12/03/2019.
//  Copyright © 2019 Александр Пономарёв. All rights reserved.
//

import Foundation

class Person: Decodable {
    let name: String
    let gender: String
    let status: String
    let species: String
    let image: String
    let origin, location: Location
}
