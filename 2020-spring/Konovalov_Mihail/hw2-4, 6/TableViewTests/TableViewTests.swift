import XCTest
@testable import TableView
import RealmSwift

class TableViewTestss: XCTestCase {
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
        sut = nil
        characterServiceMock = nil
        characterRepositorySpy = nil
    }
    
    func testCharacterToCharacterRealm() {
        let character = Character(id: 1, name: "NeAnton", image: "Ne")
        let characterRealm = CharacterRealm(character: character)
        
        XCTAssertEqual(character.id, characterRealm.id)
        XCTAssertEqual(character.name, characterRealm.name)
        XCTAssertEqual(character.image, characterRealm.image)
    }
    
    func testCharacterRealmToCharacter() {
        let characterRealm = CharacterRealm()
        characterRealm.id = 1;
        characterRealm.name = "NeAnton"
        characterRealm.image = "Image"
        let character = characterRealm.character
        XCTAssertEqual(character.id, characterRealm.id)
        XCTAssertEqual(character.name, characterRealm.name)
        XCTAssertEqual(character.image, characterRealm.image)
    }
    
    func testGetData() {
        let expectedCharacters = [Character(id: 1, name: "NeAnton", image: "Noo")]
        characterServiceMock.stubCharacters = expectedCharacters
        let expectation = self.expectation(description: #function)
        var actualCharacters: [Character]?
        sut.getCharacters { characters in
            actualCharacters = characters
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
        XCTAssertTrue(characterServiceMock.getCharactersCalled)
        XCTAssertEqual(characterRepositorySpy.savedCharacters, expectedCharacters)
        XCTAssertEqual(expectedCharacters, actualCharacters)
    }
    
    func testLoadMore() {
        let expected = [Character(id: 1, name: "Lol", image: "Lel")]
    
        characterServiceMock.stubCharacters = expected
        sut.loadMore{ _ in }
        
        XCTAssertTrue(characterServiceMock.getMoreCharactersCalled)
        XCTAssertEqual(expected, characterRepositorySpy.savedCharacters)
    }
}

private extension TableViewTestss {
    final class CharacterServiceMock: CharacterService {
        var getCharactersCalled = false
        var getMoreCharactersCalled = false
        var stubCharacters: [Character]!
        
        func getCharacters(completion: @escaping CharactersCompletion) {
            getCharactersCalled = true
            completion(stubCharacters)
        }
        
        func getMoreCharacters(completion: @escaping CharactersCompletion) {
            getMoreCharactersCalled = true
            completion(stubCharacters)
        }
    }
    
    final class CharacterRepositorySpy: CharacterRepository {
        private let actualRepository: CharacterRepositoryImpl
        var savedCharacters: [Character]!
        var getCharactersCalled = false
        
        init() {
            let configuration = Realm.Configuration(inMemoryIdentifier: "Our_test_realm")
            actualRepository = CharacterRepositoryImpl(configuration: configuration)
        }
        
        func save(_ characters: [Character]) {
            savedCharacters = characters
            actualRepository.save(characters)
        }
        
        func getCharacters() -> Results<CharacterRealm> {
            getCharactersCalled = true
            return actualRepository.getCharacters()
        }
    }
}
