//
//  Response.swift
//  News
//
//  Created by Kirill Kungurov on 14.03.2020.
//  Copyright © 2020 Kirill Kungurov. All rights reserved.
//

import Foundation

struct Response<T: Decodable> {
    let articles: [Article]
}

extension Response: Decodable {}
