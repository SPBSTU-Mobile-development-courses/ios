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
            fatalError("Cant create realm!!!")
        }
    }
    
    func save(_ characters: [Character]) {
        let characters = characters.map {
            CharacterRealm(character: $0)
        }
        try? realm.write{
            realm.add(characters,update: .modified)
        }
    }
    
    func getCharacters() -> Results<CharacterRealm> {
        return realm.objects(CharacterRealm.self)
    }
    
    
}
