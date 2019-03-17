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

    func getAll() -> Results<RealmData> {
        let realmPerson = realm.objects(RealmData.self)
        return realmPerson
    }

    func add(name: String, height: String) {
        let realmPerson = RealmData()
        realmPerson.name = name
        realmPerson.height = height
        do {
            try realm.write {
                realm.add(realmPerson)
            }
        } catch {
            print(error)
        }
    }
}
