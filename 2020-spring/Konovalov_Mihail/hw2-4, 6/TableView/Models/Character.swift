import Foundation

struct Character {
    let id: Int
    let name: String
    let image: String
}

extension Character {
    var imageUrl: URL? {
        return URL(string: image)
    }
}

extension Character: Decodable {
}

extension Character: Equatable {
    
}
