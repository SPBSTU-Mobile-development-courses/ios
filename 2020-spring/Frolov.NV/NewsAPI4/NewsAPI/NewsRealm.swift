//
//  NewsRealm.swift
//  NewsAPI
//
//  Created by Никита Фролов  on 08.04.2020.
//  Copyright © 2020 Никита Фролов . All rights reserved.
//

import RealmSwift

class NewsRealm: Object {
    @objc dynamic var title = ""
    @objc dynamic var image = ""
    @objc dynamic var author = ""
    @objc dynamic var descriptionNews = ""
    @objc dynamic var country = ""
    @objc dynamic var favorite = false
    override class func primaryKey() -> String? {
        "title"
    }
}


extension NewsRealm {
    convenience init (news:OneNew) {
        self.init()
        title = news.title ?? ""
        author = news.author ?? ""
        descriptionNews = news.description ??  ""
        image = news.urlToImage ?? ""
    }
    
    func installCountry(string: String) {
        country = string
    }
    
    func changeFlag() {
        if (favorite == false) {
            favorite = true
        } else {
            favorite = false
        }
    }
    
    var news:OneNew {
        OneNew(title: title, urlToImage: image, author: author, description: descriptionNews)
    }
}
