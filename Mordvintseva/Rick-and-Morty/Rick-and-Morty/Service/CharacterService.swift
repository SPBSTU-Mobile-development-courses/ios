//
//  CharacterService.swift
//  Rick-and-Morty
//
//  Created by Mordvintseva Alena on 18/03/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import Foundation

protocol CharacterService {
    func getCharacters(url: String, _ completionHandler: @escaping ((CharactersPage) -> Void))
    func getItemByURL<T: Decodable>(string: String, completionHandler: @escaping ((T) -> Void))
}
