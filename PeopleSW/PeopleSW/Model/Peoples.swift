import Foundation

struct Peoples: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Results]

    struct Results: Codable {
        let name: String
        let height: String
        let mass: String
        let hairColor: String
        let skinColor: String
        let eyeColor: String
        let birthYear: String
        let gender: String
        let homeworld: String
        let films: [String]
        let species: [String]
        let vehicles: [String]
        let starships: [String]
        let created: String
        let edited: String
        let url: String

        enum CodingKeys: String, CodingKey {
            case name
            case height
            case mass
            case hairColor = "hair_color"
            case skinColor = "skin_color"
            case eyeColor = "eye_color"
            case birthYear = "birth_year"
            case gender
            case homeworld
            case films
            case species
            case vehicles
            case starships
            case created
            case edited
            case url
        }
    }
}
