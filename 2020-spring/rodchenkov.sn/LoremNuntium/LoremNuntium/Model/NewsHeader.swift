import Foundation

import DeepDiff

class NewsHeader: Decodable, DiffAware {

    typealias DiffId = String

    var id: String
    var image: String
    var author: String
    var title: String
    var articleSize: Int // In real app, here would be something like a link to a full article text

    var content: String?

    var diffId: String {
        id
    }

    enum CodingKeys: String, CodingKey {
        case id
        case image = "download_url"
        case author
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.image = try container.decode(String.self, forKey: .image)
        self.author = try container.decode(String.self, forKey: .author)
        self.title = "A great new image from \(self.author)"
        self.articleSize = Int.random(in: 1...10)
    }

    init(id: String, image: String, author: String, title: String, articleSize: Int, content: String?) {
        self.id = id
        self.image = image
        self.author = author
        self.title = title
        self.articleSize = articleSize
        self.content = content
    }

    static func compareContent(_ lhs: NewsHeader, _ rhs: NewsHeader) -> Bool {
        lhs.id == rhs.id
    }

}
