//
//  ArticleServiceImpl.swift
//  News
//
//  Created by Kirill Kungurov on 17.03.2020.
//  Copyright © 2020 Kirill Kungurov. All rights reserved.
//

import Foundation

final class ArticleServiceImpl: ArticleService {
    var tag: String = "Russia"
    private var page: Int = 1
    private var baseUrl: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = "/v2/everything"
        components.queryItems = [
            URLQueryItem(name: "q", value: self.tag),
            URLQueryItem(name: "page", value: "\(self.page)"),
            URLQueryItem(name: "apiKey", value: "03ef8993d6054cd6b44d7a5ed6d95b77")
        ]
        return components.url
    }

    func getArticles(completion: @escaping AriclesCompletion) {
        guard let url = baseUrl else {
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let response = try? JSONDecoder().decode(Response<Article>.self, from: data)
            self.page += 1
            completion(response?.articles)
        }
        .resume()
    }
}
