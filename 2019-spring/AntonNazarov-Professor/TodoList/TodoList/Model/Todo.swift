//
//  Todo.swift
//  TodoList
//
//  Created by Anton Nazarov on 17/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import Foundation
import RealmSwift

final class Todo: Object {
    @objc dynamic var message = ""
    @objc dynamic var createdAt = Date()
}
