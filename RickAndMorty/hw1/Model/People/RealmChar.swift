//
//  RealmChar.swift
//  hw1
//
//  Created by Александр Пономарёв on 17/03/2019.
//  Copyright © 2019 Александр Пономарёв. All rights reserved.
//

import RealmSwift

class RealmChar: Object {
    @objc dynamic var name = ""
    @objc dynamic var gender = ""
    @objc dynamic var status = ""
    @objc dynamic var species = ""
    @objc dynamic var image = ""
    @objc dynamic var originPlanetName = ""
    @objc dynamic var originPlanetUrl = ""

    convenience init(name: String, gender: String, status: String, species: String, image: String, originPlanetName: String, originPlanetUrl: String) {
        self.init()
        self.name = name
        self.gender = gender
        self.status = status
        self.species = species
        self.image = image
        self.originPlanetName = originPlanetName
        self.originPlanetUrl = originPlanetUrl
    }
}

extension RealmChar {
    var imageUrl: URL? {
        return URL(string: image)
    }
}
