//
//  OneNew.swift
//  NewsAPIProgramm
//
//  Created by Никита Фролов  on 24.03.2020.
//  Copyright © 2020 Никита Фролов . All rights reserved.
//

import Foundation

struct Articals<T: Decodable>: Decodable {
    let author: String
    let description: String
    let urlToImage :String
    let result:[T]
}

struct OneNew: Decodable {
    let title: String
    let image: String
}



