//
//  Page.swift
//  HW2
//
//  Created by panandafog on 25.03.2020.
//  Copyright © 2020 panandafog. All rights reserved.
//

import Foundation

struct Page: Decodable{
    var data: [Post]?
    let success: Bool?
    let status: Int?    
}
