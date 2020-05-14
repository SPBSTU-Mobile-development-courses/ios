//
//  MemeRealmTests.swift
//  MemesTests
//
//  Created by panandafog on 28.03.2020.
//  Copyright © 2020 panandafog. All rights reserved.
//

@testable import Memes
import XCTest

class MemeRealmTests: XCTestCase {

    let tags = [Post.Tag(name: "lol"), Post.Tag(name: "kek"), Post.Tag(name: "cheburek")]

    func testPostToPostRealm() {
        let post = Post(id: "123",
                        title: "corona meme",
                        tags: tags,
                        images: [Post.Image(id: nil, title: nil, type: nil, link: "https://imgur.com/lmao")])
        let realm = MemeRealm(post: post)

        let tagsStr = Post.tagsToString(tags: post.tags)

        XCTAssertEqual(post.id, realm.id)
        XCTAssertEqual(post.title, realm.title)
        XCTAssertEqual(post.images?[0].link, realm.image)
        XCTAssertEqual(tagsStr, realm.tags)
    }

    func testPostRealmToPost() {
        let realm = MemeRealm()
        let post = Post(id: "123",
                        title: "corona meme",
                        tags: tags,
                        images: [Post.Image(id: nil, title: nil, type: nil, link: "https://imgur.com/lmao")])

        realm.id = post.id

        guard let image = post.images?[0].link else {
            return
        }

        realm.image = image

        let tagsStr = Post.tagsToString(tags: post.tags)

        realm.tags = tagsStr
        realm.title = post.title

        XCTAssertEqual(post.id, realm.id)
        XCTAssertEqual(post.title, realm.title)
        XCTAssertEqual(post.images?[0].link, realm.image)
        XCTAssertEqual(tagsStr, realm.tags)
    }
}
