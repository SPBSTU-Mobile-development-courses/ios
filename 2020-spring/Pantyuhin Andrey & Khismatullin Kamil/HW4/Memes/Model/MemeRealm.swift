//
//  MemeRealm.swift
//  Memes
//
//  Created by panandafog on 30.03.2020.
//  Copyright © 2020 panandafog. All rights reserved.
//

import Foundation
import RealmSwift

class MemeRealm: Object {
    @objc dynamic var id = ""
    @objc dynamic var title = ""
    @objc dynamic var image = ""
    @objc dynamic var tags = ""

    override class func primaryKey() -> String? {
        "id"
    }
}

// MARK: - MemeRealm
extension MemeRealm {
    var post: Post {
        Post(id: id, title: title, tags: [Post.Tag(name: tags)], images: [Post.Image(id: nil, title: nil, type: nil, link: image)])
    }

    convenience init(post: Post) {
        self.init()
        id = post.id
        title = post.title
        guard let images = post.images, let first = images.first else { return }
        image = first.link
        guard let tags = post.tags else { return }
        self.tags = tags.map { $0.name }.joined(separator: ", ")
    }
}
