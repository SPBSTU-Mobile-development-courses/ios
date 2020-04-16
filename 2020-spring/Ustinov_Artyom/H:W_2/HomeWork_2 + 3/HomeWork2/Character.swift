import Foundation

struct Page<T: Decodable> {
    struct Info: Decodable {
        let count: Int
        let pages: Int
        let next: String
    }

    let results: [T]
    let info: Info
}

// MARK: - Decodable
extension Page: Decodable {
}

struct Character: Decodable {
  let name: String
  let image: String
}
