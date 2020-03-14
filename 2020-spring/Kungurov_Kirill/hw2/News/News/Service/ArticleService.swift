//
//  ArticleService.swift
//  News
//
//  Created by Kirill Kungurov on 14.03.2020.
//  Copyright © 2020 Kirill Kungurov. All rights reserved.
//

import Foundation

protocol ArticleService {
    var tag: String { get }

    typealias AriclesCompletion = ([Article]?) -> Void

    func getArticles(completion: @escaping AriclesCompletion)
}

final class ArticleServiceImpl: ArticleService {
    var tag: String = "Russia"
    private var page: Int = 1
    private var baseUrl: String {
    "https://newsapi.org/v2/everything?q=\(self.tag)&page=\(self.page)&apiKey=03ef8993d6054cd6b44d7a5ed6d95b77"
    }

    func getArticles(completion: @escaping AriclesCompletion) {
        guard let url = URL(string: baseUrl) else {
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
