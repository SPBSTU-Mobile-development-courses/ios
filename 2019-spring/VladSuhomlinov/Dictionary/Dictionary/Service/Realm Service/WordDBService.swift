//
//  WordService.swift
//  Dictionary
//
//  Created by Мария on 25/03/2019.
//  Copyright © 2019 Мария. All rights reserved.
//
import Realm
import RealmSwift

class WordDBService {
    private var realm: Realm {
        guard let realm = try? Realm() else {
            fatalError("Realm can't be initialized")
        }
        return realm
    }
    var isInWriteTransaction: Bool {
        return realm.isInWriteTransaction
    }
    
    func getAllWords<Element: Object>(forType type: Element.Type) -> Results<Element> {
        let words = realm.objects(type).sorted(byKeyPath: "createdAt", ascending: false)
        return words
    }
    
    func addNewWord<Element: Object>(_ word: Element) {
        switch word {
        case let word as SearchedWord:
            add(word)
        case let word as FavouriteWord:
            add(word)
        default:
            fatalError("Unknowing type")
        }
    }
    
    func checkFavouriteWord(withTitle title: String?) -> Bool {
        if getFavouriteWord(withTitle: title?.lowercased() ?? "") != nil {
            return true
        }
        return false
    }
    
    func getFavouriteWord(withTitle title: String) -> FavouriteWord? {
        let items = realm.objects(FavouriteWord.self).filter("wordTitle = '\(title)'")
        return items.first
    }
    
    func deleteAll<Element: Object>(ofType type: Element.Type) {
        do {
            try realm.write {
                realm.delete(getAllWords(forType: type))
            }
        } catch {
            print(error)
        }
    }
    
    func delete<Element: Object>(word: Element) {
        try? realm.write {
            realm.delete(word)
        }
    }
    
    // MARK: - Private
    private func add<Element: Object>(_ word: Element) {
        do {
            try realm.write {
                realm.add(word)
            }
        } catch {
            print(error)
        }
    }
}
