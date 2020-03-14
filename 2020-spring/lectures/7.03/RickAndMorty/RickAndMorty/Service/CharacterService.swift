//
//  CharacterService.swift
//  RickAndMorty
//
//  Created by Anton Nazarov on 06.03.2020.
//  Copyright © 2020 Anton Nazarov. All rights reserved.
//

import Foundation

protocol CharacterService {
    typealias CharactersCompletion = ([Character]?) -> Void // просто чтобы не писать тип каждый раз

    func getCharacters(completion: @escaping CharactersCompletion)
    func getMoreCharacters(completion: @escaping CharactersCompletion)
}

final class CharacterServiceImpl: CharacterService {
    private let baseURL = "https://rickandmortyapi.com/api/character/"
    private var nextPage: URL? // храним внутри ссылку на следующую страницу
    
    func getCharacters(completion: @escaping CharactersCompletion) {
        guard let url = URL(string: baseURL) else {
            completion(nil)
            return
        }
        getCharacters(url: url, completion: completion)
    }

    func getMoreCharacters(completion: @escaping CharactersCompletion) {
        guard let url = nextPage else {
            completion(nil)
            return
        }
        getCharacters(url: url, completion: completion)
    }

    private func getCharacters(url: URL, completion:  @escaping CharactersCompletion) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let page = try? JSONDecoder().decode(Page<Character>.self, from: data)
            self.nextPage = URL(string: page .info.next ?? "")
            completion(page?.results)
        }
        .resume()
    }
}
