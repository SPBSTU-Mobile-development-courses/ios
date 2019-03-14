//
//  StarWarsData.swift
//  StarWarsWiki
//
//  Created by Виталий on 09.03.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

public struct Film: Decodable {
    var id: Int
    var title: String
    var releaseDate: String
    var rating: Double
    var posterPath: String?
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description = "overview"
        case releaseDate = "release_date"
        case rating = "vote_average"
        case posterPath = "poster_path"
    }
}
