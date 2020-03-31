//
//  MemeService.swift
//  HW2
//
//  Created by panandafog on 20.03.2020.
//  Copyright © 2020 panandafog. All rights reserved.
//
import Foundation

class MemeService {
    typealias PostsCompletion = ([Post]?) -> Void

    private var currentPage: Int = 0
    private var components: URL? {
        var tmp = URLComponents()
        tmp.scheme = "https"
        tmp.host = "api.imgur.com"
        tmp.path = "/3/gallery/search/viral/all/"
        tmp.queryItems = [
            URLQueryItem(name: "q", value: "memes"),
            URLQueryItem(name: "q_types", value: "jpg"),
            URLQueryItem(name: "page", value: "\(self.currentPage)")
        ]
        return tmp.url
    }

    func getMemes(completion: @escaping PostsCompletion) {
        guard let searchURL = components else {
            completion(nil)
            return
        }
        var searchRequest = URLRequest(url: searchURL)
        searchRequest.setValue("Client-ID c8828f10f679ec3", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: searchRequest) { data, _, error in
            guard let data = data, let page = try? JSONDecoder().decode(Page.self, from: data), var pageData = page.data, error == nil else {
                completion(nil)
                return
            }

            pageData.removeAll { post in
                guard let image = post.images?.first, image.type == "image/jpeg" ||  image.type == "image/png" else { return true }
                return false
            }

            completion(pageData)
        }
        .resume()
        self.currentPage += 1
        print(currentPage)
    }
}
