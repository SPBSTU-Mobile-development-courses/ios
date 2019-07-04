//
//  CharacterServiceNetwork.swift
//  Rick-and-Morty
//
//  Created by Mordvintseva Alena on 18/03/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import Alamofire
import Foundation

class CharacterServiceNetwork: CharacterService {
    func getCharacters(url: String, _ completionHandler: @escaping ((CharactersPage) -> Void)) {
        getItemByURL(string: url) { (charactersPage: CharactersPage) in
            completionHandler(charactersPage)
        }
    }

    func getItemByURL<T: Decodable>(string: String, completionHandler: @escaping ((T) -> Void)) {
        guard let url = URL(string: string) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }

            do {
                let item = try JSONDecoder().decode(T.self, from: data)
                completionHandler(item)
            } catch let error as DecodingError {
                print("DecodingError: \(error)")
            } catch {
                print("Fail:  \(error)")
            }
        }
        task.resume()
    }
}
