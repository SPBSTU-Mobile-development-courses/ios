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

    func addAll(people: [Person]) {
        do {
            try realm.write {
                for people in people {
                    let realmPerson = RealmChar(
                        name: people.name,
                        gender: people.gender,
                        status: people.status,
                        species: people.species,
                        image: people.image,
                        originPlanetName: people.origin.name,
                        originPlanetUrl: people.origin.url
                    )
                    realm.add(realmPerson)
                }
            }
        } catch {
            print(error)
        }
    }

    func searchElement(name: String) -> Results<RealmChar>? {
        if !name.contains("\\") {
            return realm.objects(RealmChar.self).filter("name CONTAINS[c] '\(name)'")
        } else {
            return nil
        }
    }
}
