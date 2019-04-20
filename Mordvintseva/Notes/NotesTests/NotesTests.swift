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
    private let note = ["title": "Title", "text": "Text", "imagePath": ""]

    override func setUp() {
        super.setUp()
        viewModel = NotesListViewModel(database: DBService())
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testOnNotesChanged() {
        var onNotesChangedWasCalled = false
        viewModel.onNotesChanged = { _ in
            onNotesChangedWasCalled = true
        }
        viewModel.load()
        XCTAssertTrue(onNotesChangedWasCalled)
    }

    func testAddNote() {
        var initValue = 0, finalValue = 0
        viewModel.onNotesChanged = { notes in
            initValue = notes.count
        }
        viewModel.load()

        viewModel.onNotesChanged = { notes in
            finalValue = notes.count
        }
        viewModel.add(note)
        viewModel.load()

        XCTAssertNotEqual(initValue, finalValue)
        viewModel.delete(Note(data: note))
    }

    func testDeleteNote() {
        var initValue = 0, finalValue = 0
        let record = Note(data: note)
        viewModel.onNotesChanged = { notes in
            initValue = notes.count
        }
        viewModel.add(record)

        viewModel.onNotesChanged = { notes in
            finalValue = notes.count
        }
        viewModel.delete(record)

        XCTAssertTrue(finalValue == initValue - 1)
    }

    func testSearchNote() {
        var initNotes = [Note]()
        var finalNotes = [Note]()
        let record = Note(data: note)

        viewModel.deleteAll()
        viewModel.onNotesChanged = { notes in
            initNotes = notes
        }
        viewModel.add(record)
        viewModel.search("Title")

        viewModel.onNotesChanged = { notes in
            finalNotes = notes
        }
        viewModel.search("nope")

        XCTAssertEqual(initNotes.count, 1)
        if let firstRecord = initNotes.first {
            XCTAssertEqual(firstRecord.text, record.text)
            XCTAssertEqual(firstRecord.title, record.title)
            XCTAssertEqual(firstRecord.imagePath, record.imagePath)
            XCTAssertEqual(firstRecord.created, record.created)
        }
        XCTAssertTrue(finalNotes.isEmpty)
    }
}
