//
//  NotesTests.swift
//  NotesTests
//
//  Created by Mordvintseva Alena on 19/04/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

@testable import Notes
import XCTest

class NotesTests: XCTestCase {
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var viewModel: NotesListViewModel!
    private let notes = [
        Note(data: ["title": "First title", "text": "Text"]),
        Note(data: ["title": "Dont forget!", "text": "Some words"]),
        Note(data: ["title": "Third title", "text": "And some new words"])
    ]
    private let note = Note(data: ["title": "test note", "text": ""])

    override func setUp() {
        super.setUp()
        viewModel = NotesListViewModel(database: MockDBService())
        notes.forEach { viewModel.add($0) }
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testOnNotesChanged() {
        // check onNotesChangedCalled
        var onNotesChangedWasCalled = false
        viewModel.onNotesChanged = { _ in
            onNotesChangedWasCalled = true
        }
        viewModel.load()

        XCTAssertTrue(onNotesChangedWasCalled)
    }

    func testAddNote() {
        // add new note and compare size of notes data
        var initValue = 0, finalValue = 0

        // get InitValue
        viewModel.onNotesChanged = { notes in
            initValue = notes.count
        }
        viewModel.load()

        // add new note and get finalValue
        viewModel.onNotesChanged = { notes in
            finalValue = notes.count
        }
        viewModel.add(note)
        viewModel.load()

        XCTAssertEqual(initValue, finalValue - 1)

        // delete test note from DB
        viewModel.delete(note)
    }

    func testDeleteNote() {
        // delete note with text "some words" and then check notes size
        var initValue = 0

        // get initValue
        viewModel.onNotesChanged = { notes in
            initValue = notes.count
        }
        viewModel.search("some words")

        XCTAssertEqual(initValue, 1)
    }

    func testSearchNote() {
        // find note with title "First note", its size 1
        var result = [Note]()

        viewModel.onNotesChanged = { notes in
            result = notes
        }
        viewModel.search("First title")
        print(result)

        XCTAssertEqual(result.count, 1)
        if let firstRecord = result.first {
            let note = notes[0]
            XCTAssertEqual(firstRecord.title, note.title)
            XCTAssertEqual(firstRecord.text, note.text)
            XCTAssertEqual(firstRecord.imagePath, note.imagePath)
            XCTAssertEqual(firstRecord.created, note.created)
        }
    }

    func testSearchSeveralNotes() {
        // find all notes with title contains "title" word, its size 2
        var result = [Note]()

        viewModel.onNotesChanged = { notes in
            result = notes
        }
        viewModel.search("Title")

        XCTAssertEqual(result.count, 2)
    }
}

private class MockDBService: DBService {
    private var notes: [Note] = []

    func getAll() -> [Note] {
        return notes
    }

    func add(_ note: Note) {
        notes.append(note)
    }

    func delete(_ note: Note) {
        if let index = notes.index(of: note) {
            notes.remove(at: index)
        }
    }

    func deleteAll() {
        notes = []
    }

    func search(_ text: String) -> [Note] {
        let result = notes.filter { $0.title.lowercased().contains(text.lowercased()) || $0.text.lowercased().contains(text.lowercased()) }
        return result
    }
}
