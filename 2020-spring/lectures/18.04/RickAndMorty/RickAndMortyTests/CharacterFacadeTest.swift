//
//  CharacterFacadeTest.swift
//  RickAndMortyTests
//
//  Created by Anton Nazarov on 06.03.2020.
//  Copyright © 2020 Anton Nazarov. All rights reserved.
//

import XCTest
import RealmSwift
@testable import RickAndMorty

final class CharacterFacadeTest: XCTestCase {
    private var characterFacade: CharacterFacade!
    private var characterServiceMock: CharacterServiceMock!
    private var characterRepositorySpy: CharacterRepositorySpy!

    override func setUp() {
        super.setUp()
        characterServiceMock = CharacterServiceMock()
        characterRepositorySpy = CharacterRepositorySpy()
        characterFacade = CharacterFacadeImpl(characterService: characterServiceMock, characterRepository: characterRepositorySpy)
    }

    override func tearDown() {
        characterServiceMock = nil
        characterRepositorySpy = nil
        characterFacade = nil
        super.tearDown()
    }

    func testCharacterToRealmCharacterConvert() {
        let character = Character(id: 1, name: "lol", image: "lel")
        let realmCharacter = CharacterRealm(character: character)
        XCTAssertEqual(character.id, realmCharacter.id)
        XCTAssertEqual(character.image, realmCharacter.image)
        XCTAssertEqual(character.name, realmCharacter.name)
    }

    func testCharacterRealmToCharacterConvert() {
        let realmCharacter = CharacterRealm()
        realmCharacter.id = 1
        realmCharacter.name = "lel"
        realmCharacter.image = "lol"
        let character = realmCharacter.character
        XCTAssertEqual(character.id, realmCharacter.id)
        XCTAssertEqual(character.image, realmCharacter.image)
        XCTAssertEqual(character.name, realmCharacter.name)
    }

    func testGetDataTriggerService() {
        // Given
        let expectedCharacters = [Character(id: 0, name: "John", image: "Doe")]
        var actualCharacters: [Character]?
        characterServiceMock.characters = expectedCharacters
        let expectation = self.expectation(description: #function)
        // When
        characterFacade.getCharacters {
            actualCharacters = $0
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        // Then
        XCTAssertTrue(characterServiceMock.getCharactersCalled)
        XCTAssertEqual(characterRepositorySpy.saveCalled, expectedCharacters)
        XCTAssertTrue(characterRepositorySpy.getCharactersCalled)
        XCTAssertEqual(expectedCharacters, actualCharacters)
    }

    func testLoadMore() {
        // Given
        let expectedCharacters = [Character(id: 0, name: "John", image: "Doe")]
        characterServiceMock.characters = expectedCharacters
        // When
        characterFacade.loadMore()
        // Then
        XCTAssertTrue(characterServiceMock.getMoreCharactersCalled)
        XCTAssertEqual(expectedCharacters, characterRepositorySpy.saveCalled)
    }
}

// MARK: - Stubs
private extension CharacterFacadeTest {
    final class CharacterServiceMock: CharacterService {
        var characters: [Character]?
        var getCharactersCalled = false
        var getMoreCharactersCalled = false

        func getCharacters(completion: @escaping CharactersCompletion) {
            getCharactersCalled = true
            completion(characters)
        }

        func getMoreCharacters(completion: @escaping CharactersCompletion) {
            getMoreCharactersCalled = true
            completion(characters)
        }
    }

    final class CharacterRepositorySpy: CharacterRepository {
        private let actualCharacterRepository: CharacterRepositoryImpl
        var saveCalled: [Character]?
        var getCharactersCalled = false

        init() {
            let configuration = Realm.Configuration(inMemoryIdentifier:  String(describing: type(of: self)))
            actualCharacterRepository = CharacterRepositoryImpl(configuration: configuration)
        }

        func save(_ characters: [Character]) {
            saveCalled = characters
            actualCharacterRepository.save(characters)
        }

        func getCharacters() -> Results<CharacterRealm> {
            getCharactersCalled = true
            return actualCharacterRepository.getCharacters()
        }
    }
}
