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

extension Page: Decodable {
}
