import RealmSwift

class CharacterRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var image = ""

    override class func primaryKey() -> String? {
        "id"
    }
}

extension CharacterRealm {
    convenience init(character: Character) {
        self.init()
        id = character.id
        name = character.name
        image = character.image
    }

    var character: Character {
        Character(id: id, name: name, image: image)
    }
}
