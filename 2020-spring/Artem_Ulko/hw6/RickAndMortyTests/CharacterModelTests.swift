//
//  CharacterModelTests.swift
//  RickAndMortyTests
//
//  Created by user on 18.05.2020.
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
}
