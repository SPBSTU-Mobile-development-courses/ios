import Foundation

struct Info: Decodable {
    let next: String
}

struct Page<T: Decodable> {
    struct Info: Decodable {
        let count: Int
        let pages: Int
        let next: String
    }

    let results: [T]
    let info: Info
}

struct Character: Decodable {
    let image: String
    let name: String
}

extension Page: Decodable {
}
