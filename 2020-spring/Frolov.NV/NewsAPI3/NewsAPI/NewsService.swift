//
//  NewsService.swift
//  NewsAPI
//
//  Created by Никита Фролов  on 25.03.2020.
//  Copyright © 2020 Никита Фролов . All rights reserved.
//

import Foundation


class NewsService {
    private var pageNumber:Int = 1;
    
    private var urlComponents = URLComponents(string: "https://newsapi.org")
    private var nextUrl: URL?
    private var contry: [String]?
    private var contryId:Int = 0
    
    
    public func getNews(completion: @escaping ([OneNew]?)-> Void) {
        contry = [
            String("us"),
            String("ru"),
            String("pl"),
            String("ro"),
            String("ua")
        ]
        urlComponents?.path = "/v2/top-headlines"
        urlComponents?.queryItems = [
            URLQueryItem(name: "country", value: contry?[contryId]),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "apiKey", value: "e5a2d92c79b74e8aa40a9e618e6a1998")
        ]
        guard let url = urlComponents?.url else {
            completion(nil)
            return
        }
        getNews(url: url,completion: completion)
    }
    
    public func getMoreNews(complition: @escaping ([OneNew]?)-> Void) {
        guard let url = nextUrl else {
            complition(nil)
            return
        }
        getNews(url: url, completion: complition)
    }
    
    private func getNextPage()-> URL{
        pageNumber += 1;
        urlComponents?.queryItems?[1].value = String(pageNumber)
        guard let newUrl = urlComponents?.url else {
            fatalError("Problem with URL")
        }
        return newUrl
    }
    
    public func changeCountry() {
        contryId += 1;
        if (contryId >= 6) {
            contryId = 0
        }
        urlComponents?.queryItems?[0].value = contry?[contryId]
        guard let _ = urlComponents?.url else {
            fatalError("Problem with URL")
        }
    }
    
    private func getNews(url: URL, completion: @escaping ([OneNew]?)->Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(nil)
                return
            }
            let articals = try? JSONDecoder().decode(Articals<OneNew>.self, from: data)
            self.nextUrl = self.getNextPage()
            completion(articals?.articles)
        }.resume()
    }
}
