//
//  CharacterRealm.swift
//  RickAndMorty
//
//  Created by user on 30.04.2020.
//  Copyright © 2020 ulkoart. All rights reserved.
//

import RealmSwift

class CharacterRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var image = ""
    @objc dynamic var status = ""

    override class func primaryKey() -> String? {
        "id"
    }
}

extension CharacterRealm {
    convenience init(character: Character) {
        self.init()
        id = character.id
        name = character.name
        image = character.image
        status = character.status
    }

    var character: Character {
        Character(id: id, name: name, image: image, status: status)
    }
}
