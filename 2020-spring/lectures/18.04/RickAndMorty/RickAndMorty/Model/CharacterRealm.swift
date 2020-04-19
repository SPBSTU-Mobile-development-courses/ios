//
//  CharacterRealm.swift
//  RickAndMorty
//
//  Created by Anton Nazarov on 28.03.2020.
//  Copyright © 2020 Anton Nazarov. All rights reserved.
//

import RealmSwift

class CharacterRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var image = ""

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
    }

    var character: Character {
        Character(id: id, name: name, image: image)
    }
}
