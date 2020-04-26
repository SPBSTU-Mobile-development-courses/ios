//
//  Post.swift
//  Memes
//
//  Created by panandafog on 20.03.2020.
//  Copyright © 2020 panandafog. All rights reserved.
//

import DeepDiff
import Foundation

struct Post: Decodable {
    struct Image: Decodable {
        let id: String?
        let title: String?
        let type: String?
        let link: String
        var url: URL? {
            URL(string: link)
        }
    }
    struct Tag: Decodable {
        let name: String
    }

    let id: String
    let title: String
    let tags: [Tag]?
    let images: [Image]?

    var tagsNames: String {
        guard let tags = self.tags else { return "" }
        return tags.map { $0.name }.joined(separator: ", ")
    }
}

// MARK: - Equatable
extension Post: Equatable {
    static func == (lhs: Post, rhs: Post) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - DiffAware
extension Post: DiffAware {
    typealias DiffId = String

    var diffId: DiffId {
        id
    }

    static func compareContent(_ lhs: Post, _ rhs: Post) -> Bool {
        lhs == rhs
    }
}
