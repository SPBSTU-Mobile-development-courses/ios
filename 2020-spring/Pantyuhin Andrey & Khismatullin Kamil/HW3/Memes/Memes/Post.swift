//
//  Post.swift
//  HW2
//
//  Created by panandafog on 20.03.2020.
//  Copyright © 2020 panandafog. All rights reserved.
//
import Foundation

struct Post: Decodable {
    struct Image: Decodable {
        let id: String?
        let title: String?
        let type: String
        let link: String
        var url: URL? {
            URL(string: link)
        }
    }
    struct Tag: Decodable {
        let name: String
    }

    let id: String?
    let title: String?
    let tags: [Tag]?
    let images: [Image]?
}
