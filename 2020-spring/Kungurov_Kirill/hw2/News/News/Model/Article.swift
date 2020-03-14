//
//  Article.swift
//  News
//
//  Created by Kirill Kungurov on 14.03.2020.
//  Copyright © 2020 Kirill Kungurov. All rights reserved.
//

import Foundation

struct Article {
    let author: String?
    let title: String
    let description: String
    let publishedAt: String
    private let url: String
    private let urlToImage: String?
}

extension Article {
    var imageUrl: URL? {
        guard let urlToImage = self.urlToImage else { return nil }
        if urlToImage.contains("default") {
            return nil
        }
        return URL(string: urlToImage)
    }
    var articleUrl: URL? {
        URL(string: url)
    }
    var date: String {
        //return "13/10/2019"
        return String(publishedAt.split(separator: "T")[0])
    }
}

extension Article: Decodable {}
