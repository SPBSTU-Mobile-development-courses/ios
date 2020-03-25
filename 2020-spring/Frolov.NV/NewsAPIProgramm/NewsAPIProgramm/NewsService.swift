//
//  NewsService.swift
//  NewsAPIProgramm
//
//  Created by Никита Фролов  on 24.03.2020.
//  Copyright © 2020 Никита Фролов . All rights reserved.
//

import Foundation

class NewsService {
    private var pageNumber:Int = 1;
    private var baseURL = "http://newsapi.org/v2/top-headlines?country=ru&page=1&apiKey=e5a2d92c79b74e8aa40a9e618e6a1998"
    private var nextUrl: URL?
    
    public func getNews(complition: @escaping ([OneNew]?)-> Void) {
        guard let url = URL(string: baseURL) else {
            complition(nil)
            return
        }
        getNews(url: url,complition: complition)
    }
    
    public func getMoreNews(complition: @escaping ([OneNew]?)-> Void) {
        guard let url = nextUrl else {
            complition(nil)
            return
        }
        getNews(url: url, complition: complition)
    }
    
    private func getNextPage()-> String{
        pageNumber += 1;
        return "http://newsapi.org/v2/top-headlines?country=us&page=\(pageNumber)&apiKey=e5a2d92c79b74e8aa40a9e618e6a1998"
    }
    
    private func getNews(url: URL, complition: @escaping ([OneNew]?)->Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                complition(nil)
                return
            }
            let articals = try? JSONDecoder().decode(Articals<OneNew>.self, from: data)
            self.nextUrl = URL(string: self.getNextPage())
            complition(articals?.result)
        }.resume()
    }
}
