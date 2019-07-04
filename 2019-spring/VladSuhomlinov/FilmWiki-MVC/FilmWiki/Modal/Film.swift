//
//  StarWarsData.swift
//  StarWarsWiki
//
//  Created by Виталий on 09.03.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

public struct  FilmResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case results
    }
    let results: [Film]
}

public struct Film: Decodable {
    var id: Int?
    var title: String?
    var releaseDate: String?
    var rating: Double?
    var posterPath: String?
    var description: String?
    enum CodingKeys: String, CodingKey {
        case id, title, adult, genres,
             description = "overview",
             releaseDate = "release_date",
             rating = "vote_average",
             posterPath = "poster_path"
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decode(Int.self, forKey: .id)
        self.title = try? container.decode(String.self, forKey: .title)
        self.releaseDate = try? container.decode(String.self, forKey: .releaseDate)
        self.rating = try? container.decode(Double.self, forKey: .rating)
        self.posterPath = try? container.decode(String.self, forKey: .posterPath)
        self.description = try? container.decode(String.self, forKey: .description)
    }
}
