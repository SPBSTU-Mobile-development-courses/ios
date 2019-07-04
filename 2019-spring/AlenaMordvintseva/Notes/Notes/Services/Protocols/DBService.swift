//
//  DBServiceProtocol.swift
//  Notes
//
//  Created by Mordvintseva Alena on 02/05/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import Foundation

protocol DBService {
    func getAll() -> [Note]
    func add(_ note: Note)
    func delete(_ note: Note)
    func deleteAll()
    func search(_ text: String) -> [Note]
}
