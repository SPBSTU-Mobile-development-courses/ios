//
//  CharacterServiceNetwork.swift
//  First_app
//
//  Created by Mordvintseva Alena on 10/03/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import Foundation

class CharacterServiceNetwork: CharacterService {
    func getCharacters(_ completionHandler: @escaping (([Character]) -> Void)) {
        var characters: [Character] = []
        var urlAdress: String? = "https://swapi.co/api/people/"

        while let urlString = urlAdress {
            guard let url = URL(string: urlString) else { return }
            getItemByURL(url: url) { (charactersPage: CharactersPage) in
                characters.append(contentsOf: charactersPage.results)
                urlAdress = charactersPage.next
            }
        }
        completionHandler(characters)
    }

    func getItemByURL<T: Decodable>(url: URL, completionHandler: @escaping ((T) -> Void)) {
        let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            defer { semaphore.signal() }
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
        _ = semaphore.wait(timeout: .distantFuture)
    }
}
