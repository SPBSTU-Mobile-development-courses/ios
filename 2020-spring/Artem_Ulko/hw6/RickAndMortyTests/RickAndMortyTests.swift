//
//  RickAndMortyTests.swift
//  RickAndMortyTests
//
//  Created by user on 19.05.2020.
//  Copyright © 2020 ulkoart. All rights reserved.
//

@testable import RickAndMorty
import RealmSwift
import XCTest

class RickAndMortyTests: XCTestCase {
    private var sut: CharacterFacade!
    private var characterServiceMock: CharacterServiceMock!
    private var characterRepositorySpy: CharacterRepositorySpy!

    override func setUp() {
        super.setUp()
        characterServiceMock = CharacterServiceMock()
        characterRepositorySpy = CharacterRepositorySpy()
        sut = CharacterFacadeImpl(characterService: characterServiceMock, characterRepository: characterRepositorySpy)
    }
    
    override func tearDown() {
        super.tearDown()
        characterServiceMock = nil
        characterRepositorySpy = nil
        sut = nil
    }
    
    func testGetData() -> Void {
        // Given
        let expectedCharacters = [
            Character(id: 0, name: "John0", image: "Doe0", status: "Dead"),
            Character(id: 1, name: "John1", image: "Doe2", status: "Dead"),
            Character(id: 2, name: "John2", image: "Doe3", status: "Dead"),
        ]
        characterServiceMock.stubCharacters = expectedCharacters
        let expectation = self.expectation(description: #function)
        var actualCharacters: [Character]?
        // When
        sut.getCharacters {characters in
            actualCharacters = characters
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
        // Then
        XCTAssertTrue(characterServiceMock.getCharactersCalled)
        XCTAssertEqual(characterRepositorySpy.saved, expectedCharacters)
        XCTAssertEqual(expectedCharacters, actualCharacters)
    }
    
    func testLoadMore() -> Void {
        let expectedCharacters = [
            Character(id: 0, name: "John3", image: "Doe3", status: "Dead"),
            Character(id: 1, name: "John4", image: "Doe4", status: "Alive"),
            Character(id: 2, name: "John5", image: "Doe5", status: "Dead"),
        ]
        let expectation = self.expectation(description: #function)
        characterServiceMock.stubCharacters = expectedCharacters
        sut.loadMore {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)

        XCTAssertTrue(characterServiceMock.getMoreCharactersCalled)
        XCTAssertEqual(expectedCharacters, characterRepositorySpy.saved)
    }

}

private extension RickAndMortyTests {
    final class CharacterServiceMock: CharacterService {
        var getCharactersCalled = false
        var getMoreCharactersCalled = false
        var stubCharacters: [Character]!

        func getCharacters(completion: @escaping ([Character]) -> Void) {
            getCharactersCalled = true
            completion(stubCharacters)
        }

        func getMoreCharacters(completion: @escaping ([Character]) -> Void) {
            getMoreCharactersCalled = true
            completion(stubCharacters)
        }
    }
    
    final class CharacterRepositorySpy: CharacterRepository {
        private let actualRepository: CharacterRepositoryImpl
        var saved:[Character]!
        var getCharactersCalled = false
        
        init() {
            let configuration = Realm.Configuration(inMemoryIdentifier: "TestDB")
            actualRepository = .init(configuration: configuration)
        }
        
        func save(_ characters: [Character]) {
            saved = characters
            actualRepository.save(characters)
        }
        
        func getCharacters() -> Results<CharacterRealm> {
            getCharactersCalled = true
            return actualRepository.getCharacters()
        }
        
        
    }
}
