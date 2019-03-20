//
//  UsersService.swift
//  UsersInformation
//
//  Created by Artem on 19/03/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

import Foundation

protocol UsersService {
    func getPage(url: String?, _ completionHandler: @escaping ((User?) -> Void))
    func sendUser(user: User?, _ completionHandler: @escaping ((Bool) -> Void))
}
