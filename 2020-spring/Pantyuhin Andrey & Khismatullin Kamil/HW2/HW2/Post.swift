//
//  Post.swift
//  HW2
//
//  Created by panandafog on 20.03.2020.
//  Copyright © 2020 panandafog. All rights reserved.
//

import Foundation

struct Page: Decodable{
    var data: [Post]?
    let success: Bool?
    let status: Int?
    
}

struct Post: Decodable{
    let id: String?
    let title: String?
    let tags: [Tag]?
    let images: [Image]?
}

struct Tag: Decodable {
    let name: String?
}

struct Image: Decodable{
   let id: String?
   let title: String?
   let type: String?
   let link: String
}
extension Image{
    var url: URL? {
        URL(string: link)
    }
}
