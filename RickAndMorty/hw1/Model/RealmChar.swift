//
//  RealmChar.swift
//  hw1
//
//  Created by Александр Пономарёв on 17/03/2019.
//  Copyright © 2019 Александр Пономарёв. All rights reserved.
//

import RealmSwift

class RealmChar: Object {
    @objc dynamic var name = ""
    @objc dynamic var gender = ""
    @objc dynamic var image = ""
}
