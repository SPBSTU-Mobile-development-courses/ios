//
//  WordService.swift
//  Dictionary
//
//  Created by Мария on 25/03/2019.
//  Copyright © 2019 Мария. All rights reserved.
//

import RealmSwift

class WordDBService {
    private var realm: Realm {
        guard let realm = try? Realm() else {
            fatalError("Realm can't be initialized")
        }
        return realm
    }
    
    func getAllWords<Element: Object>(forType type: Element.Type) -> Results<Element> {
        let words = realm.objects(type).sorted(byKeyPath: "createdAt", ascending: false)
        return words
    }

    func addWord(withTitle title: String) {
        let word = SearchedWord(wortTitle: title)
        do {
            try realm.write {
                realm.add(word)
            }
        } catch {
            print(error)
        }
    }
    
    func deleteAll() {
        try? realm.write {
            realm.deleteAll()
        }
    }
    
    func delete<Element: Object>(word: Element) {
        try? realm.write {
            realm.delete(word)
        }
    }
}
