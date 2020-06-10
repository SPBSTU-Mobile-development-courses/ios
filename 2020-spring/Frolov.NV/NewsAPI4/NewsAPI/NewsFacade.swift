//
//  NewsFacade.swift
//  NewsAPI
//
//  Created by Никита Фролов  on 08.04.2020.
//  Copyright © 2020 Никита Фролов . All rights reserved.
//

import Foundation
import RealmSwift


final class NewsFacade {
    private let newsService:NewsService!
    private let newRepository = NewsRepositoryImpl()
    private var newsToken: NotificationToken?
    private var country:String
    
    init(string:String) {
        country = string
        newsService = NewsService(string: country)
    }
    
    func getNews(completion: @escaping ([OneNew]?)-> Void) {
        newsService.getNews { (newsArray) in
            guard let news = newsArray else {return}
            self.newRepository.installCountry(string: self.country)
            self.newRepository.save(news)
        }
        let newsArray = newRepository.getNews()
        var newsArr = [NewsRealm]()
        for i in 0..<newsArray.count {
            if (newsArray[i].country == self.country) {
                let new = newsArray[i]
                newsArr.append(new)
            }
        }
        newsToken = newsArray.observe{_ in
            completion(newsArr.map{$0.news})
        }
    }
    
    func getFavoriteNews(completion: @escaping ([OneNew]?)-> Void) {
        let newsArray = newRepository.getNews()
        var newsArr = [NewsRealm]()
        for i in 0..<newsArray.count {
            if (newsArray[i].favorite) {
                let new = newsArray[i]
                newsArr.append(new)
            }
        }
        newsToken = newsArray.observe{_ in
            completion(newsArr.map{$0.news})
        }
    }
    
    func getToFavoriteList(news: OneNew) {
        newRepository.changeFavoriteStatus(news: news)
    }
    
    func deleteFromFavorite(news: OneNew) {
        newRepository.changeFavoriteStatus(news: news)
    }
    
    func reload(completion: @escaping ([OneNew]?)-> Void) {
        //newRepository.cleare()
        getNews(completion: completion)
    }
    
    func loadMore() {
        newsService.getMoreNews {(newsArray) in
            guard let news = newsArray else {return}
            self.newRepository.save(news)
        }
    }
}
