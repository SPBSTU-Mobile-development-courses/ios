//
//  CharacterServiceNetwork.swift
//  First_app
//
//  Created by Mordvintseva Alena on 10/03/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import Foundation

class CharacterServiceNetwork: CharacterService {
    func getCharacters(urlString: String, _ completionHandler: @escaping ((CharactersPage) -> Void)) {
        guard let url = URL(string: urlString) else { return }
        getItemByURL(url: url) { (charactersPage: CharactersPage) in
            completionHandler(charactersPage)
        }
    }

    func getItemByURL<T: Decodable>(url: URL, completionHandler: @escaping ((T) -> Void)) {
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
