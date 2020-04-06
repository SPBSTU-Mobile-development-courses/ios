//
//  CharacterService.swift
//  RickAndMorty
//
//  Created by Nikita Pinaev on 16.03.2020.
//  Copyright © 2020 Nikita Pinaev. All rights reserved.
//

import Foundation

class CharacterService {
    typealias CharactersCompletion = ([Character]?) -> Void

   private let baseURL = "https://rickandmortyapi.com/api/character/"
    private var nextPage: URL?
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
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let page = try? JSONDecoder().decode(Page<Character>.self, from: data)
            self.nextPage = URL(string: page?.info.next ?? "")
            completion(page?.results)
        }
        .resume()
    }
}
