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
    
    func checkFavouriteWord(_ word: Word, _ completionHandler: (FavouriteWord) -> Void) {
        guard let favouriteWord = findFavouriteWord(withTitle: word.title) else { return }
        completionHandler(favouriteWord)
    }
    
    func updateFavouriteWord(_ word: FavouriteWord, isFavourite: Bool) {
        realm.cancelWrite()
        do {
            try realm.write {
                word.isFavourite = isFavourite
                guard isFavourite else {
                    delete(word: word)
                    return
                }
                addNewWord(word)
            }
        } catch {
            print(error)
        }
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
    
    private func findFavouriteWord(withTitle title: String) -> FavouriteWord? {
        let items = realm.objects(FavouriteWord.self).filter("wordTitle = '\(title)'")
        return items.first
    }
}
