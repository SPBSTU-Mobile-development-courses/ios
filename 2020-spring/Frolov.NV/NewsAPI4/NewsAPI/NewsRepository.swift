//
//  NewsRepository.swift
//  NewsAPI
//
//  Created by Никита Фролов  on 08.04.2020.
//  Copyright © 2020 Никита Фролов . All rights reserved.
//

import RealmSwift

protocol NewsRepository {
    func save(_ news:[OneNew])
    func getNews()-> Results<NewsRealm>
}

final class NewsRepositoryImpl: NewsRepository {
    private var realm:Realm {
        do {
            return try Realm()
        } catch {
            fatalError("Can't create realm")
        }
    }
    private var country = ""
    func installCountry(string: String) {
        country = string
    }
    
    
    func save(_ news: [OneNew]) {
        let news = news.map{ NewsRealm(news: $0) }
        news.forEach({$0.installCountry(string: self.country)})
        try? realm.write{
            realm.add(news, update: .modified)
        }
    }
    
    func changeFavoriteStatus(news: OneNew) {
        try? realm.write {
            let newsArray = realm.objects(NewsRealm.self).filter({$0.title == news.title}).first
            newsArray?.changeFlag()
        }
    }
    
    func cleare() {
        try? realm.write{
            realm.deleteAll()
        }
    }
    
    func getNews() -> Results<NewsRealm> {
        realm.objects(NewsRealm.self)
    }
}
