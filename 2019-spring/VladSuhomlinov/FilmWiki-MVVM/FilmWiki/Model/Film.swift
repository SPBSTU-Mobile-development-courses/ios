//
//  StarWarsData.swift
//  StarWarsWiki
//
//  Created by Виталий on 09.03.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

public struct Film: Decodable {
    let id: Int
    let title: String
    let releaseDate: String
    let voteAverage: Double
    let posterPath: String?
    let overview: String
}
