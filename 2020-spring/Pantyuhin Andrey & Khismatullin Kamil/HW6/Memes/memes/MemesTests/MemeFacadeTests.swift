//
//  MemeFacadeTests.swift
//  MemesTests
//
//  Created by panandafog on 14.05.2020.
//  Copyright © 2020 panandafog. All rights reserved.
//

@testable import Memes
import RealmSwift
import XCTest

class MemeFacadeTests: XCTestCase {

    private var facade: MemeFacade!
    private var serviceMock: MemeServiceMock!
    private var repositorySpy: MemeRepositorySpy!

    let expectedPosts = [
        Post(id: "123",
             title: "corona meme",
             tags: [Post.Tag(name: "lol"), Post.Tag(name: "kek"), Post.Tag(name: "cheburek")],
             images: [Post.Image(id: nil, title: nil, type: nil, link: "https://imgur.com/lmao")])
    ]

    override func setUp() {
        super.setUp()
        serviceMock = MemeServiceMock()
        repositorySpy = MemeRepositorySpy()
        facade = MemeFacadeImpl(memeService: serviceMock, memeRepository: repositorySpy)
    }

    override func tearDown() {

        serviceMock = nil
        repositorySpy = nil
        facade = nil
        super.tearDown()
    }

    func testGetMemes() {
        serviceMock.stubPosts = expectedPosts
        let expectation = self.expectation(description: #function)
        var actualPosts: [Post]?
        facade.getMemes { posts in
            actualPosts = posts
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
        XCTAssertEqual(actualPosts, self.expectedPosts)
        XCTAssertTrue(serviceMock.getMemesCalled)
        XCTAssertEqual(repositorySpy.saved, expectedPosts)
    }

    func testLoadMore() {
        serviceMock.stubPosts = expectedPosts
        facade.loadMore()
        XCTAssertTrue(serviceMock.getMoreMemesCalled)
        XCTAssertEqual(repositorySpy.saved, expectedPosts)
    }
}

private extension MemeFacadeTests {
    final class MemeServiceMock: MemeService {
        var getMemesCalled = false
        var getMoreMemesCalled = false
        var stubPosts: [Post]?

        override func getMemes(newPage: Bool, completion: @escaping MemeService.PostsCompletion) {
            getMemesCalled = true
            getMoreMemesCalled = newPage

            completion(stubPosts)
        }
    }

    final class MemeRepositorySpy: MemeRepository {
        private let actualRepository: MemeRepositoryImpl

        var saved: [Post]?
        var getMemesCalled = false

        init() {
            let configuration = Realm.Configuration(inMemoryIdentifier: "test_realm")
            actualRepository = .init(configuration: configuration)
        }

        func save(_ posts: [Post]) {
            saved = posts
            actualRepository.save(posts)
        }

        func getMemes() -> Results<MemeRealm> {
            getMemesCalled = true
            return actualRepository.getMemes()
        }

        func clear() {
            actualRepository.clear()
        }

        func count() -> Int {
            saved?.count ?? 0
        }
    }
}
