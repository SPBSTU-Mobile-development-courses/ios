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
    private let calendary = Calendar.current
    private let date = Date()
    var day:Int
    var month:Int
    var year:Int
    private var country:String
    
    init(string:String) {
        country = string
        day = calendary.component(.day, from: date)
        month = calendary.component(.month, from: date)
        year = calendary.component(.year, from: date)
    }
    
    public func getNews(completion: @escaping ([OneNew]?)-> Void) {
        urlComponents?.path = "/v2/top-headlines"
        let dayF = day
        let monthF = month
        let yearF = year
        if (day == 1) {
            if (month == 1) {
                year = year - 1
            } else {
                month = month - 1
            }
        } else {
            day = day - 1
        }
        urlComponents?.queryItems = [
            URLQueryItem(name: "country", value: country),
            //URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "apiKey", value: "e5a2d92c79b74e8aa40a9e618e6a1998"),
            URLQueryItem(name: "from", value: "\(yearF)-\(monthF)-\(dayF)"),
            URLQueryItem(name: "to", value: "\(year)-\(month)-\(day)")
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
        if (day == 1) {
            if (month == 1) {
                year = year - 1
            } else {
                month = month - 1
            }
        } else {
            day = day - 1
        }
        urlComponents?.queryItems?[3].value = String("\(year)-\(month)-\(day)")
        guard let newUrl = urlComponents?.url else {
            fatalError()
        }
        return newUrl
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
