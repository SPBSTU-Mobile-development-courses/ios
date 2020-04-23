import Foundation

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String
}

struct Page<T: Decodable>: Decodable {
    let results: [T]
    let info: Info
}

struct Character: Decodable {
    let id: Int
    let name: String
    let image: String
}

extension Character {
    var imageURL: URL? {
        URL(string: image)
    }
}
