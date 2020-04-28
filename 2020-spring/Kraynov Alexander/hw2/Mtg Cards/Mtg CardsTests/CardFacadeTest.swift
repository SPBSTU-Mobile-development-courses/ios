//
//  CardFacadeTest.swift
//  Mtg CardsTests
//
//  Created by Александр Крайнов on 23.04.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

@testable import Mtg_Cards
import RealmSwift
import XCTest

class CardFacadeTest: XCTestCase {
    //swiftlint:disable implicitly_unwrapped_optional
    private var cardFacade: CardFacade!
    private var cardServiceMock: CardServiceMock!
    private var cardRepositorySpy: CardRepositorySpy!
    private let testCard = Card(
            id: "1",
            name: "John Appleseed",
            artist: "Vincent",
            rarity: "rare",
            flavorText: "nice",
            imageUris: Card.CardFaceImages(normal: "hey")
    )

    override func setUp() {
        super.setUp()
        cardRepositorySpy = CardRepositorySpy()
        cardServiceMock = CardServiceMock()
        cardFacade = CardFacadeImpl(cardService: cardServiceMock, cardRepository: cardRepositorySpy)
    }
    //swiftlint:endable implicitly_unwrapped_optional

    override func tearDown() {
        cardServiceMock = nil
        cardRepositorySpy = nil
        cardFacade = nil
        super.tearDown()
    }

    func testCardToRealmConvert() {
        let card = testCard
        let realmcard = CardRealm(card: card)
        XCTAssertEqual(card.id, realmcard.id)
        XCTAssertEqual(card.artist, realmcard.artist)
        XCTAssertEqual(card.rarity, realmcard.rarity)
        XCTAssertEqual(card.flavorText, realmcard.flavorText)
        XCTAssertEqual(card.imageUris?.normal, realmcard.normalResImage)
        XCTAssertEqual(card.name, realmcard.name)
    }

    func testRealmTocardConvert() {
        let realmcard = CardRealm()
        realmcard.id = "Kanye"
        realmcard.name = "West"
        realmcard.flavorText = "I keep it 300, like the Romans"
        realmcard.normalResImage = "https://i.redd.it/jpfgemmi8x531.png"
        realmcard.rarity = "legendary"
        realmcard.artist = "god"
        let card = realmcard.card
        XCTAssertEqual(card.id, realmcard.id)
        XCTAssertEqual(card.artist, realmcard.artist)
        XCTAssertEqual(card.flavorText, realmcard.flavorText)
        XCTAssertEqual(card.rarity, realmcard.rarity)
        XCTAssertEqual(card.imageUris?.normal, realmcard.normalResImage)
        XCTAssertEqual(card.name, realmcard.name)
    }

    func testGetDataTriggerService() {
        // Given
        let expectedCards = [testCard]
        var actualCards: [Card] = []
        cardServiceMock.cards = expectedCards
        let expectation = self.expectation(description: #function)
        // When
        cardFacade.getCards {
            actualCards = $0 ?? []
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        // Then
        XCTAssertTrue(cardServiceMock.getCardsCalled)
        XCTAssertEqual(cardRepositorySpy.savedCards, expectedCards)
        XCTAssertTrue(cardRepositorySpy.getCardsCalled)
        XCTAssertEqual(expectedCards, actualCards)
    }

    func testLoadMore() {
        // Given
        let expectedCards = [testCard]
        cardServiceMock.cards = expectedCards
        // When
        cardFacade.loadMore { _ in }
        // Then
        XCTAssertTrue(cardServiceMock.getMoreCardsCalled)
        XCTAssertEqual(expectedCards, cardRepositorySpy.savedCards)
    }
}

private extension CardFacadeTest {
    final class CardServiceMock: CardService {
        var cards: [Card] = []
        var getCardsCalled = false
        var getMoreCardsCalled = false

        func getCards(completion: @escaping CardCompletion) {
            getCardsCalled = true
            completion(cards)
        }

        func getMoreCards(completion: @escaping CardCompletion) {
            getMoreCardsCalled = true
            completion(cards)
        }
    }

    final class CardRepositorySpy: CardRepository {
        private var actualCardRepository: CardRepositoryImpl
        var savedCards: [Card] = []
        var getCardsCalled = false

        init() {
            let configuration = Realm.Configuration(inMemoryIdentifier: String(describing: type(of: self)))
            actualCardRepository = CardRepositoryImpl(configuration: configuration)
        }

        func save(_ cards: [Card]) {
            savedCards = cards
            actualCardRepository.save(cards)
        }

        func getCards() -> Results<CardRealm> {
            getCardsCalled = true
            return actualCardRepository.getCards()
        }
    }
}
