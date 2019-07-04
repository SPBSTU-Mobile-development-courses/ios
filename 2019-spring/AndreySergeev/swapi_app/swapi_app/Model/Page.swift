//
//  Page.swift
//  swapi_app
//
//  Created by Andrew on 27/04/2019.
//  Copyright © 2019 SPbSTU. All rights reserved.
//

struct Page: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Person]
}
