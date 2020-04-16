import RealmSwift

protocol CharacterRepository {
    func save(_ characters: [Character])
    func getCharecters() -> Results<CharacterRealm>
    func clear()
}

class CharacterRepositoryImpl: CharacterRepository {
    private var realm: Realm {
        do {
            return try Realm()
        } catch {
            fatalError("Can't create realm")
        }
    }

    func clear() {
        try? realm.write {
            realm.deleteAll()
        }
    }

    func save(_ characters: [Character]) {
        let characters = characters.map { CharacterRealm(character: $0) }
        try? realm.write {
            realm.add(characters, update: .modified)
        }
    }

    func getCharecters() -> Results<CharacterRealm> {
        realm.objects(CharacterRealm.self)
    }
}
