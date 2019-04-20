//
//  DBService.swift
//  Notes
//
//  Created by Mordvintseva Alena on 12/04/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import Foundation
import RealmSwift

class DBService {
    private var realm: Realm {
        guard let realm = try? Realm() else {
            fatalError("Realm can't be initialized")
        }
        return realm
    }

    func getAll() -> [Note] {
        let result = realm.objects(Note.self)
        return transformResultsToArray(result: result)
    }

    func add(_ note: Note) {
        do {
            try realm.write {
                realm.add(note)
            }
        } catch {
            print(error)
        }
    }

    func delete(_ note: Note) {
        do {
            try realm.write {
                realm.delete(realm.objects(Note.self))
            }
        } catch {
            print(error)
        }
    }

    func deleteAll() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print(error)
        }
    }

    func search(_ text: String) -> [Note] {
        let predicate = NSPredicate(format: "title CONTAINS [c]%@ OR text CONTAINS [c]%@", text, text)
        let result = realm.objects(Note.self).filter(predicate)
        return transformResultsToArray(result: result)
    }

    private func transformResultsToArray(result: Results<Note>) -> [Note] {
        var notes = [Note]()
        result.forEach {
            notes.append($0)
        }
        return notes
    }
}
