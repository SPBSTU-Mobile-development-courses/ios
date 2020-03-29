//
//  UsersRealm.swift
//  UsersInformation
//
//  Created by Artem on 27/03/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

import RealmSwift

final class UsersRealm {
    private var realm: Realm {
        guard let realm = try? Realm() else {
            fatalError("Realm do not inicialized")
        }
        return realm
    }
    // For Auth
    func getUsers() -> User {
        let users = realm.objects(UserInRealm.self)
        var user = User()
        user.name = users.last?.name
        user.age = users.last?.age
        user.gender = users.last?.gender
        user.height = users.last?.height
        user.mass = users.last?.mass
        return user
    }

    func updateMainUser(user: User) {
        try? realm.write {
            realm.delete(realm.objects(UserInRealm.self))
        }
        let userToBase = UserInRealm()
        userToBase.name = user.name ?? "Unknown"
        userToBase.age = user.age ?? "Unknown"
        userToBase.gender = user.gender ?? "Unknown"
        userToBase.height = user.height ?? "Unknown"
        userToBase.mass = user.mass ?? "Unknown"
        do {
            try realm.write {
                realm.add(userToBase)
            }
        } catch {
            print(error)
        }
    }
}
