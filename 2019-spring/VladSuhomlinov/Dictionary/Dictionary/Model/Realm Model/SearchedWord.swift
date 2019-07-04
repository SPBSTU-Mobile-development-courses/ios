//
//  WordHistory.swift
//  Dictionary
//
//  Created by Мария on 25/03/2019.
//  Copyright © 2019 Мария. All rights reserved.
//

import RealmSwift

class SearchedWord: Object {
    @objc dynamic var wordTitle = ""
    @objc dynamic var createdAt = Date()
    
    convenience init(wortTitle: String) {
        self.init()
        self.wordTitle = wortTitle
    }
}
