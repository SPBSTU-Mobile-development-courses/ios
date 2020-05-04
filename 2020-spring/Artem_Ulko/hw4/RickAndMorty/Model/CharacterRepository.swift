//
//  CharacterRepository.swift
//  RickAndMorty
//
//  Created by user on 30.04.2020.
//  Copyright © 2020 ulkoart. All rights reserved.
//

import RealmSwift

protocol CharacterRepository {
    func save(_ characters: [Character])
    func getCharacters() -> Results<CharacterRealm>
}

final class CharacterRepositoryImpl: CharacterRepository {
    private var realm: Realm {
        do {
            return try Realm()
        } catch {
            fatalError("realm fail")
        }
    }

    func save(_ characters: [Character]) {
        let characters = characters.map { CharacterRealm(character: $0) }
        try? realm.write {
            realm.add(characters, update: .modified)
        }
    }

    func getCharacters() -> Results<CharacterRealm> {
        realm.objects(CharacterRealm.self)
    }
}
