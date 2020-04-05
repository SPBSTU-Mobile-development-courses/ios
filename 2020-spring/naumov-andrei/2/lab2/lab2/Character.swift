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
    let name: String
    let image: String
}
