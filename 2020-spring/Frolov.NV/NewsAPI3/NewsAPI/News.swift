//
//  News.swift
//  NewsAPI
//
//  Created by Никита Фролов  on 25.03.2020.
//  Copyright © 2020 Никита Фролов . All rights reserved.
//

import Foundation

struct Articals<T: Decodable>: Decodable {
    let articles:[T]
}

struct OneNew: Decodable {
    let title: String?
    let urlToImage: String?
    let author: String?
    let description: String?
}
