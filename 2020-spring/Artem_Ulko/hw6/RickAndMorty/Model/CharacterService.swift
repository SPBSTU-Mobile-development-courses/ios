//
//  CharacterService.swift
//  RickAndMorty
//
//  Created by user on 22.04.2020.
//  Copyright © 2020 ulkoart. All rights reserved.
//
import Foundation
import UIKit

class CharacterService {

    let baseURL = "https://rickandmortyapi.com/api/character/"
    var nextPage: URL?

    func getCharacters(completion: @escaping ([Character]) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion([])
            return
        }
        getCharactersResponse(url: url, completion: completion)
    }

    func getMoreCharacters(completion: @escaping ([Character]) -> Void) {
        guard let url = nextPage else {
            completion([])
            return
        }
        getCharactersResponse(url: url, completion: completion)
    }

    func getCharactersResponse(url: URL, completion:  @escaping ([Character]) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion([])
                return
            }
            let page = try? JSONDecoder().decode(Page<Character>.self, from: data)
            self.nextPage = URL(string: page?.info.next ?? "")
            completion(page?.results ?? [])
        }
        .resume()
    }

    class func getCharacterImage(url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) {data, _, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            let downloadedImage = UIImage(data: data)
            completion(downloadedImage, nil)

        }
        task.resume()
    }

}
