//
//  CharacterRealm.swift
//  TableView
//
//  Created by Михаил Коновалов  on 12/04/2020.
//  Copyright © 2020 Михаил Коновалов . All rights reserved.
//

import RealmSwift

class CharacterRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var image = ""
    
    
    override class func primaryKey()-> String? {
        return "id"
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
        return Character(id: id, name: name, image: image)
    }
}
