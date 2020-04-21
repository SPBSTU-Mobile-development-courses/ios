//
//  CharacterService.swift
//  homework_2
//
//  Created by Никита on 09/03/2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation

enum CharacterService {
    private static var next: String = "https://pokeapi.co/api/v2/pokemon"

    static func getCharacters(competition: @escaping ([Character]) -> Void) {
        guard let url = URL(string: next) else {
            competition([Character]())
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            guard let page = try? JSONDecoder().decode(Page<Character>.self, from: data)
            else {
                competition([Character]())
                return
            }
            next = page.next
            competition(page.results)
        }
        .resume()
    }

    static func getCharacterDescription(character: Character, completition: @escaping (CharacterDescription?) -> Void) {
        guard let url = URL(string: character.url) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
           guard let data = data else { return }
           guard let characterDescription = try? JSONDecoder().decode(CharacterDescription.self, from: data)
           else {
               return
           }
           completition(characterDescription)
        }
        .resume()
    }
}
