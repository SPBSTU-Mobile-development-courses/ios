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
    var post: Post?
    var realm: MemeRealm?
    var tagsStr: String?

    override func setUp() {
        super.setUp()

        let post = Post(id: "123",
                        title: "corona meme",
                        tags: tags,
                        images: [Post.Image(id: nil, title: nil, type: nil, link: "https://imgur.com/lmao")])

        realm = MemeRealm(post: post)
        tagsStr = Post.tagsToString(tags: post.tags)
        self.post = post
    }

    func testPostToPostRealm() {
        guard let post = post, let realm = realm else {
            return
        }

        XCTAssertEqual(post.id, realm.id)
        XCTAssertEqual(post.title, realm.title)
        XCTAssertEqual(post.images?[0].link, realm.image)
        XCTAssertEqual(tagsStr, realm.tags)
    }

    func testPostRealmToPost() {
        guard let post = post, let realm = realm, let tagsStr = tagsStr else {
            return
        }

        realm.id = post.id

        guard let image = post.images?[0].link else {
            return
        }

        realm.image = image

        realm.tags = tagsStr
        realm.title = post.title

        XCTAssertEqual(post.id, realm.id)
        XCTAssertEqual(post.title, realm.title)
        XCTAssertEqual(post.images?[0].link, realm.image)
        XCTAssertEqual(tagsStr, realm.tags)
    }
}
