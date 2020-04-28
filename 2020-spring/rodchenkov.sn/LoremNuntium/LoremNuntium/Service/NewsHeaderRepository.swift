import RealmSwift

class NewsHeaderRepository: NHRepository {

    private let config: Realm.Configuration

    private var realm: Realm {
        do {
            return try Realm(configuration: config)
        } catch {
            fatalError("could not create realm.")
        }
    }

    init(config: Realm.Configuration = .defaultConfiguration) {
        self.config = config
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
