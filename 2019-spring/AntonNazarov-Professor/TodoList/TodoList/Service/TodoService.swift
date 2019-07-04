//
//  TodoService.swift
//  TodoList
//
//  Created by Anton Nazarov on 17/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import RealmSwift

// все доки здесь - https://realm.io/docs/swift/latest/
final class TodoService {
    private var realm: Realm {
        guard let realm = try? Realm() else {
            fatalError("Realm can't be initialized")
        }
        return realm
    }

    func getAll() -> Results<Todo> {
        let todos = realm.objects(Todo.self).sorted(byKeyPath: "createdAt", ascending: false)
        return todos
    }

    func add(todoText: String) {
        let todo = Todo()
        todo.message = todoText
        do {
            try realm.write {
                realm.add(todo)
            }
        } catch {
            print(error)
        }
    }

    func delete(todo: Todo) {
        try? realm.write {
            realm.delete(todo)
        }
    }
}
