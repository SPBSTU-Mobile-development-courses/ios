//
//  DataBaseService.swift
//  Rick-and-Morty
//
//  Created by Mordvintseva Alena on 19/03/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import Foundation
import RealmSwift

class DBManager {
    private var realm: Realm {
        guard let realm = try? Realm() else {
            fatalError("Realm can't be initialized")
        }
        return realm
    }

    func getAll() -> Results<CharacterRecord> {
        let characters = realm.objects(CharacterRecord.self).sorted(byKeyPath: "name", ascending: false)
        return characters
    }

    func add(_ character: Character) {
        let characterRecord = CharacterRecord(character: character)
        do {
            try realm.write {
                realm.add(characterRecord)
            }
        } catch {
            print(error)
        }
    }

    func add(_ character: [Character]) {
        for item in character {
            self.add(item)
        }
    }
}
