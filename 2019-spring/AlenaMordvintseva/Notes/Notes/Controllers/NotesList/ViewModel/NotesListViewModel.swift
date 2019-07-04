//
//  NotesListViewModel.swift
//  Notes
//
//  Created by Mordvintseva Alena on 19/04/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import Foundation

class NotesListViewModel: NotesListViewModelProtocol {
    private let database: DBService
    private var notes = [Note]() {
        didSet {
            onNotesChanged?(notes)
        }
    }

    var onNotesChanged: (([Note]) -> Void)?

    init (database: DBService) {
        self.database = database
    }

    func load() {
        notes = database.getAll()
    }

    func add(_ note: Note) {
        database.add(note)
        notes = database.getAll()
    }

    func delete(_ note: Note) {
        database.delete(note)
        notes = database.getAll()
    }

    func deleteAll() {
        database.deleteAll()
        notes = database.getAll()
    }

    func search(_ text: String) {
        if text.isEmpty == false {
            notes = database.search(text)
        } else {
            notes = database.getAll()
        }
    }
}
