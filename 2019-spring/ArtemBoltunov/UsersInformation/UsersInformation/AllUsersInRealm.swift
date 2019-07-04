//
//  AllUsersInRealm.swift
//  UsersInformation
//
//  Created by Artem on 29/03/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

import Foundation
import RealmSwift

class AllUsersInRealm: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = ""
    @objc dynamic var gender = ""
    @objc dynamic var mass = ""
    @objc dynamic var height = ""
}
