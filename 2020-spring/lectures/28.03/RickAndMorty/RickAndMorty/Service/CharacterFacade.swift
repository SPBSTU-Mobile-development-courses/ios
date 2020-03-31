//
//  CharacterFacade.swift
//  RickAndMorty
//
//  Created by Anton Nazarov on 28.03.2020.
//  Copyright © 2020 Anton Nazarov. All rights reserved.
//

import RealmSwift

protocol CharacterFacade {
    typealias OnUpdateCharacters = ([Character]?) -> Void

    func getCharacters(completion: @escaping OnUpdateCharacters)
    func loadMore() -> bool
}

final class CharacterFacadeImpl: CharacterFacade {
    private let characterRepository: CharacterRepository
    private let characterService: CharacterService
    private var charactersToken: NotificationToken?

    init(characterService: CharacterService, characterRepository: CharacterRepository) {
        self.characterRepository = characterRepository
        self.characterService = characterService
    }

    func loadMore() {
        characterService.getMoreCharacters {
            guard let characters = $0 else { return }
            self.characterRepository.save(characters)
        }
    }

    func getCharacters(completion: @escaping OnUpdateCharacters) {
        characterService.getCharacters {
            guard let characters = $0 else { return }
            self.characterRepository.save(characters)
        }
        let characters = characterRepository.getCharacters()
        charactersToken = characters.observe { _ in
            completion(characters.map { $0.character })
        }
    }
}
