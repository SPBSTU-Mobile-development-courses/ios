//
//  AllUsersRealm.swift
//  UsersInformation
//
//  Created by Artem on 29/03/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

import RealmSwift

final class AllUsersRealm {
    private var realm: Realm {
        guard let realm = try? Realm() else {
            fatalError("Realm do not inicialized")
        }
        return realm
    }
    // For UsersView: Users List

    func getAllUsers() -> [User] {
        let users = Array(realm.objects(AllUsersInRealm.self))
        var resultUsers = [User]()
        for item in users {
            var newUser = User()
            newUser.name = item.name
            newUser.age = item.age
            newUser.gender = item.gender
            newUser.height = item.height
            newUser.mass = item.mass
            resultUsers.append(newUser)
        }
        return resultUsers
    }

    func updateAllUsers(users: [User]) {
        try? realm.write {
            realm.delete(realm.objects(AllUsersInRealm.self))
        }
        for item in users {
            let userToBase = AllUsersInRealm()
            userToBase.name = item.name ?? "Unknown"
            userToBase.age = item.age ?? "Unknown"
            userToBase.gender = item.gender ?? "Unknown"
            userToBase.height = item.height ?? "Unknown"
            userToBase.mass = item.mass ?? "Unknown"
            do {
                try realm.write {
                    realm.add(userToBase)
                }
            } catch {
                print(error)
            }
        }
    }
}
