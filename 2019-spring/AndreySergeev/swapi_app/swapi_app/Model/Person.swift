//
//  Person.swift
//  swapi_app
//
//  Created by Andrew on 27/04/2019.
//  Copyright © 2019 SPbSTU. All rights reserved.
//

import RealmSwift

class Person: Object, Decodable{
    @objc dynamic var name: String
    @objc dynamic var height: String
    @objc dynamic var mass: String
    @objc dynamic var hairColor: String
    @objc dynamic var skinColor: String
    @objc dynamic var eyeColor: String
    @objc dynamic var birthYear: String
    @objc dynamic var gender: String
    @objc dynamic var homeworld: String
    @objc dynamic var films: [String]
    @objc dynamic var species: [String]
    @objc dynamic var vehicles: [String]
    @objc dynamic var starships: [String]
    @objc dynamic var created: String
    @objc dynamic var edited: String
    @objc dynamic var url: String
}
