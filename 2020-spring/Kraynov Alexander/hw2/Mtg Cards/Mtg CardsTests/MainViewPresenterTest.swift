//
//  MainViewPresenterTest.swift
//  Mtg CardsTests
//
//  Created by Александр Крайнов on 23.04.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

@testable import Mtg_Cards
import XCTest

class MainViewPresenterTest: XCTestCase {
    //swiftlint:disable implicitly_unwrapped_optional
    private var cardFacadeStub: CardFacadeStub!
    private var presenter: MainViewPresenter!
    private var mainViewControllerMock: MainViewControllerMock!
    //swiftlint:enable implicitly_unwrapped_optional

    override func setUp() {
        super.setUp()
        cardFacadeStub = CardFacadeStub()
        mainViewControllerMock = MainViewControllerMock()
        presenter = MainViewPresenter(view: mainViewControllerMock, facade: cardFacadeStub)
    }

    override func tearDown() {
        cardFacadeStub = nil
        presenter = nil
        super.tearDown()
    }

    func testPresenterPassesGetCards() {
        var actualCards = [Card]()
        let expectation = self.expectation(description: #function)
        presenter.getCards { cards in
            actualCards = cards ?? []
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        XCTAssertEqual(actualCards, [cardFacadeStub.testCardFirst])
        XCTAssert(mainViewControllerMock.reloadTableViewCalled)
    }

    func testPresenterPassesLoadMore() {
        var actualCards = [Card]()
        let expectation = self.expectation(description: #function)
        presenter.loadMore { cards in
            actualCards = cards ?? []
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        XCTAssertEqual(actualCards, [cardFacadeStub.testCardSecond])
    }
}

private extension MainViewPresenterTest {
    final class CardFacadeStub: CardFacade {
        let testCardFirst = Card(
                id: "1",
                name: "John Appleseed",
                artist: "Vincent",
                rarity: "rare",
                flavorText: "nice",
                imageUris: Card.CardFaceImages(normal: "hey")
        )

        let testCardSecond = Card(
            id: "Kanye",
            name: "West",
            artist: "god",
            rarity: "legendary",
            flavorText: "I keep it 300, like the Romans",
            imageUris: Card.CardFaceImages(normal: "https://i.redd.it/jpfgemmi8x531.png")
        )

        func getCards(completion: @escaping OnUpdateCompletion) {
            completion([testCardFirst])
        }

        func loadMore(completion: @escaping OnUpdateCompletion) {
            completion([testCardSecond])
        }
    }

    final class MainViewControllerMock: MainViewController {
        var reloadTableViewCalled = false

        override func reloadTableView() {
            reloadTableViewCalled = true
        }
    }
}
