import RealmSwift

class NewsHeaderRepository {

    private var realm: Realm {
        do {
            return try Realm()
        } catch {
            fatalError("could not create realm.")
        }
    }

    func save(_ newsHeaders: [NewsHeader]) {
        try? realm.write {
            realm.add(
                newsHeaders.map {
                    NewsHeaderRealm(newsHeader: $0)
                },
                update: .modified
            )
        }
    }

    func load() -> Results<NewsHeaderRealm> {
        realm.objects(NewsHeaderRealm.self)
    }

}
