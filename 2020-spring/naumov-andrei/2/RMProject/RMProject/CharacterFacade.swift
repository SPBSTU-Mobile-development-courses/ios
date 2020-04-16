import Foundation
import RealmSwift

protocol CharacterFacade {
    typealias CharactersCompletion = ([Character]?) -> Void

    func clear()
    func loadMore()
    func getCharacters(completion: @escaping CharactersCompletion)
}

class CharacterFacadeImpl: CharacterFacade {
    private let characterService: CharacterService
    private let characterRepository: CharacterRepository
    private var charactersToken: NotificationToken?

    init(characterService: CharacterService, characterRepository: CharacterRepository) {
        self.characterRepository = characterRepository
        self.characterService = characterService
    }

    func clear() {
        characterRepository.clear()
    }

    func loadMore() {
        characterService.getMoreCharacters {
            guard let characters = $0 else { return }
            self.characterRepository.save(characters)
        }
    }

    func getCharacters(completion: @escaping CharactersCompletion) {
        characterService.getCharacters {
            guard let characters = $0 else { return }
            self.characterRepository.save(characters)
        }
        let characters = characterRepository.getCharecters()
        charactersToken = characters.observe { _ in
            completion(characters.map { $0.character })
        }
    }
}
