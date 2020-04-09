//
//  NewsFacade.swift
//  NewsAPI
//
//  Created by Никита Фролов  on 08.04.2020.
//  Copyright © 2020 Никита Фролов . All rights reserved.
//

import Foundation
import RealmSwift
import Network

final class NewsFacade {
    private let newsService = NewsService()
    private let newRepository = NewsRepositoryImpl()
    private var newsToken: NotificationToken?
    
    func getNews(completion: @escaping ([OneNew]?)-> Void) {
        newsService.getNews { (newsArray) in
            guard let news = newsArray else {return}
            self.newRepository.save(news)
        }
        let newsArray = newRepository.getNews()
        newsToken = newRepository.getNews().observe{_ in
            completion(newsArray.map{$0.news})
        }
    }
    
    func reload(completion: @escaping ([OneNew]?)-> Void) {
        
        newRepository.cleare()
        newsService.changeContry()
        
        newsService.getNews { (newsArray) in
            guard let news = newsArray else {return}
            self.newRepository.save(news)
        }
        
        let newsArray = newRepository.getNews()
        newsToken = newRepository.getNews().observe{_ in
            completion(newsArray.map{$0.news})
        }
    }
    
    func loadMore() {
        newsService.getMoreNews {(newsArray) in
            guard let news = newsArray else {return}
            self.newRepository.save(news)
        }
    }
}
