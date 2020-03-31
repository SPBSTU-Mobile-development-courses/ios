//
//  CardServiceImpl.swift
//  Mtg Cards
//
//  Created by Admin on 31.03.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import Foundation

final class CardServiceImpl: CardService {
    private let baseURL = "https://api.scryfall.com/cards"
    private var nextPage: URL?

    func getCards(completion: @escaping CardCompletion) {
        guard let url = URL(string: baseURL) else {
            completion(nil)
            return
        }
        getCards(url: url, completion: completion)
    }

    func getMoreCards(completion: @escaping CardCompletion) {
        guard let url = nextPage else {
            completion(nil)
            return
        }
        getCards(url: url, completion: completion)
    }

    private func getCards(url: URL, completion: @escaping CardCompletion) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            var page: CardPage<Card>?
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                page = try? decoder.decode(CardPage<Card>.self, from: data)
                self.nextPage = URL(string: page?.nextPage ?? "")
            completion(page?.data)
        }
    .resume()
    }
}
