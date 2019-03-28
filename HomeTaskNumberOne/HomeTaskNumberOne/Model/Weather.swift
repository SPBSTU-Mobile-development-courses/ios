//
//  Weather.swift
//  HomeTaskNumberOne
//
//  Created by Максим Егоров on 15/03/2019.
//  Copyright © 2019 Максим Егоров. All rights reserved.
//

struct Weather: Decodable {
    let location: Location
    let current: Current
}
