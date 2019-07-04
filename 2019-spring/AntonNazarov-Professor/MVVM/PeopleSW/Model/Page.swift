import Foundation

struct Page: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Person]
}
