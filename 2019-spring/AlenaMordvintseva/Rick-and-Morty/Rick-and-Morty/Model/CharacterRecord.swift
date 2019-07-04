//
//  CharacterRecord.swift
//  Rick-and-Morty
//
//  Created by Mordvintseva Alena on 19/03/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import Foundation
import RealmSwift

class CharacterRecord: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var status = ""
    @objc dynamic var species = ""
    @objc dynamic var type = ""
    @objc dynamic var gender = ""
    @objc dynamic var image = ""
    @objc dynamic var url = ""

    convenience init(character: Character) {
        self.init()
        self.id = character.id
        self.name = character.name
        self.status = character.status
        self.species = character.species
        self.type = character.type
        self.gender = character.gender
        self.image = character.image
        self.url = character.url
    }
}
