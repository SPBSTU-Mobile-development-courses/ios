//
//  User.swift
//  UsersInformation
//
//  Created by Artem on 19/03/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

import Foundation

struct User: Codable {
    var id, login, password, name: String?
    var age, gender, mass: String?
    var height: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case login, name, password, age, gender, height, mass
    }
}
