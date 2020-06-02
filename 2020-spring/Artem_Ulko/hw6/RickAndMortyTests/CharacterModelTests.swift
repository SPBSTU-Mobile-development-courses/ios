//
//  CharacterModelTests.swift
//  RickAndMortyTests
//
//  Created by user on 19.05.2020.
//  Copyright © 2020 ulkoart. All rights reserved.
//

@testable import RickAndMorty
import XCTest

class CharacterModelTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    func testCharacterModel() {
        let character = Character(id: 0, name: "John", image: "Doe", status: "Alive")
        let characterReal = CharacterRealm(character: character)
        XCTAssertEqual(character.id, characterReal.id)
        XCTAssertEqual(character.name, characterReal.name)
        XCTAssertEqual(character.image, characterReal.image)
        XCTAssertEqual(character.status, characterReal.status)
    }

    func testCharacterToRealCharacter() {
        let characterReal = CharacterRealm()
        characterReal.id = 0
        characterReal.name = "John"
        characterReal.image = "Doe"
        characterReal.status = "Alive"
        let character = characterReal.character
        XCTAssertEqual(character.id, characterReal.id)
        XCTAssertEqual(character.name, characterReal.name)
        XCTAssertEqual(character.image, characterReal.image)
        XCTAssertEqual(character.status, characterReal.status)
    }
}
