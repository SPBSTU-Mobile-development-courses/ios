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
    var date: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        guard let startDate = dateFormatter.date(from: publishedAt) else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        guard let endDate = formatter.string(for: startDate) else { return nil }
        return endDate
    }
}

extension Article: Decodable {}
