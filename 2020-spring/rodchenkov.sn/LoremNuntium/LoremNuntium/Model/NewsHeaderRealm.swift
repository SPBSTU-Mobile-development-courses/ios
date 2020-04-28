import RealmSwift

class NewsHeaderRealm: Object {
    @objc dynamic var id = ""
    @objc dynamic var image = ""
    @objc dynamic var author = ""
    @objc dynamic var title = ""
    @objc dynamic var articleSize = 0
    @objc dynamic var content = ""

    override class func primaryKey() -> String? {
        "id"
    }

    convenience init(newsHeader: NewsHeader) {
        self.init()
        id = newsHeader.id
        image = newsHeader.image
        author = newsHeader.author
        title = newsHeader.title
        articleSize = newsHeader.articleSize
        content = newsHeader.content ?? ""
    }

    var newsHeader: NewsHeader {
        NewsHeader(
            id: id,
            image: image,
            author: author,
            title: title,
            articleSize: articleSize,
            content: content.isEmpty ? nil : content
        )
    }

}
