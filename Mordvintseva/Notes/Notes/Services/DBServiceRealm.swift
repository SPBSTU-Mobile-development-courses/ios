//
//  DBService.swift
//  Notes
//
//  Created by Mordvintseva Alena on 12/04/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import Foundation
import RealmSwift

class DBServiceRealm: DBService {
    private var realm: Realm {
        guard let realm = try? Realm() else {
            fatalError("Realm can't be initialized")
        }
        return realm
    }

    func getAll() -> [Note] {
        let result = realm.objects(Note.self)
        return Array(result)
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
                let format = "title == %@ AND text == %@ AND imagePath == %@ AND created == %@"
                let predicate = NSPredicate(format: format, note.title, note.text, note.imagePath, note.created as NSDate)
                let request = realm.objects(Note.self).filter(predicate)
                if let record = request.first {
                    realm.delete(record)
                }
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
        return Array(result)
    }
}
