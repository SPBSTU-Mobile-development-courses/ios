import Foundation
import RealmSwift

protocol CharacterFacade {
    typealias OnUpdateCharacters = ([Character]?) -> Void
    
    func getCharacters(completion: @escaping OnUpdateCharacters)
    func loadMore(completion: @escaping OnUpdateCharacters)
}

final class CharacterFacadeImpl: CharacterFacade {
    private let characterService: CharacterService
    private let characterRepository: CharacterRepository
    private var characterToken: NotificationToken?
    
    init(characterService: CharacterService, characterRepository: CharacterRepository) {
        self.characterService = characterService
        self.characterRepository = characterRepository
    }
    
    func getCharacters(completion: @escaping OnUpdateCharacters) {
        characterService.getCharacters {
            guard let characters = $0 else { return }
            self.characterRepository.save(characters)
        }
        let characters = characterRepository.getCharacters()
        characterToken = characters.observe { _ in
            completion(characters.map { $0.character})
        }
    }
    
    func loadMore(completion: @escaping OnUpdateCharacters) {
        characterService.getMoreCharacters {
            guard let characters = $0 else { return }
            self.characterRepository.save(characters)
        }
    }
    
    
}
