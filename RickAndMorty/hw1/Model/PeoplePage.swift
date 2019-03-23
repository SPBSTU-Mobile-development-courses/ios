//
//  PeoplePage.swift
//  hw1
//
//  Created by Александр Пономарёв on 12/03/2019.
//  Copyright © 2019 Александр Пономарёв. All rights reserved.
//

class PeoplePage: Decodable {
    let next: String?
    let results: [Person]
}
