import RealmSwift

protocol NHRepository {
    func save(_ newsHeaders: [NewsHeader])
    func load() -> Results<NewsHeaderRealm>
}
