//
//  NotesListViewModelProtocol.swift
//  Notes
//
//  Created by Mordvintseva Alena on 19/04/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import Foundation

protocol NotesListViewModelProtocol {
    var onNotesChanged: (([Note]) -> Void)? { get set }

    func load()
    func add(_ note: Note)
    func delete(_ note: Note)
    func deleteAll()
    func search(_ text: String)
}
