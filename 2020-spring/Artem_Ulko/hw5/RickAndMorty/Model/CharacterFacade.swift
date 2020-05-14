//
//  CharacterFacade.swift
//  RickAndMorty
//
//  Created by user on 30.04.2020.
//  Copyright © 2020 ulkoart. All rights reserved.
//

import Foundation
import RealmSwift

protocol CharacterFacade {
    typealias OnUpdateCharacter = ([Character]) -> Void

    func getCharacters(completion: @escaping OnUpdateCharacter)
    func loadMore(completion: @escaping () -> Void)
}

final class CharacterFacadeImpl: CharacterFacade {
    private let characterService = CharacterService()
    private let characterRepository = CharacterRepositoryImpl()
    private var characterToken: NotificationToken?

    func getCharacters(completion: @escaping OnUpdateCharacter) {
        characterService.getCharacters { characters in
            self.characterRepository.save(characters)
        }
        let characters = characterRepository.getCharacters()
        characterToken = characters.observe { _ in
            completion(characters.map { $0.character })
        }
    }

    func loadMore(completion: @escaping () -> Void) {
        characterService.getMoreCharacters { characters in
            self.characterRepository.save(characters)
            completion()
        }
    }
}
