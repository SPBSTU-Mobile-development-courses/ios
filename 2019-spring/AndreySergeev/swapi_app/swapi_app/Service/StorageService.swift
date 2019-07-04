//
//  StorageService.swift
//  swapi_app
//
//  Created by Andrew on 16/05/2019.
//  Copyright © 2019 SPbSTU. All rights reserved.
//

import Foundation
import RealmSwift

final class StorageService {
    private var realm: Realm {
        guard let realm = try? Realm() else {
            fatalError("Can't initialize Realm!")
        }
        return realm
    }
    
    public func store(data: [Person]) {
        try? realm.write {
            realm.add(data)
        }
    }
    
    public func clear() {
        try? realm.write {
            realm.deleteAll()
        }
    }
    
    public func getData() -> [Person] {
        return Array(realm.objects(Person.self))
    }
}
