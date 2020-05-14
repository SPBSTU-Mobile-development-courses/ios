//
//  MemeRepository.swift
//  Memes
//
//  Created by panandafog on 30.03.2020.
//  Copyright © 2020 panandafog. All rights reserved.
//

import RealmSwift

protocol MemeRepository {
    func save(_ posts: [Post])
    func getMemes() -> Results<MemeRealm>
    func clear()
    func count() -> Int
}

final class MemeRepositoryImpl: MemeRepository {
    private let configuration: Realm.Configuration
    
    var realm: Realm {
        do {
            return try Realm(configuration: configuration)
        } catch {
            fatalError("Realm can't be created")
        }
    }

    init(configuration: Realm.Configuration) {
        self.configuration = configuration
    }

    func save(_ posts: [Post]) {
        let posts = posts.map(MemeRealm.init(post:))
        try? realm.write {
            realm.add(posts, update: .modified)
        }
    }

    func getMemes() -> Results<MemeRealm> {
        realm.objects(MemeRealm.self)
    }

    func clear() {
        try? realm.write {
          realm.deleteAll()
        }
    }

    func count() -> Int {
        realm.objects(MemeRealm.self).count
    }
}
