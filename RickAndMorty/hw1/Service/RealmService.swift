//
//  RealmService.swift
//  hw1
//
//  Created by Александр Пономарёв on 17/03/2019.
//  Copyright © 2019 Александр Пономарёв. All rights reserved.
//

import RealmSwift

class RealmService {
    private var realm: Realm {
        guard let realm = try? Realm() else {
            fatalError("Realm can't be initialized")
        }
        return realm
    }

    func getAll() -> Results<RealmChar> {
        let realmPerson = realm.objects(RealmChar.self)
        return realmPerson
    }

    func add(person: Person) {
        let realmPerson = RealmChar()
        realmPerson.name = person.name
        realmPerson.gender = person.gender
        realmPerson.image = person.image
        do {
            try realm.write {
                realm.add(realmPerson)
            }
        } catch {
            print(error)
        }
    }
}
