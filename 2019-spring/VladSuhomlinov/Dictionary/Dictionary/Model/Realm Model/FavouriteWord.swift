//
//  FavouriteWord.swift
//  Dictionary
//
//  Created by Мария on 29/03/2019.
//  Copyright © 2019 Мария. All rights reserved.
//

import RealmSwift

class FavouriteWord: SearchedWord {
    @objc dynamic var isFavourite = false
    
    convenience init(wordTitle: String, isFavourite: Bool) {
        self.init(wortTitle: wordTitle)
        self.isFavourite = isFavourite
    }
}
