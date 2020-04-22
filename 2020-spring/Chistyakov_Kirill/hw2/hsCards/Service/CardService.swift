//
//  CardService.swift
//  hsCards
//
//  Created by Kirill Chistyakov on 17.03.2020.
//  Copyright © 2020 Kirill Chistyakov. All rights reserved.
//

import Foundation
protocol CardService {
    typealias CardsCompletion = ([Card]?) -> Void // просто чтобы не писать тип каждый раз
    typealias AuthCompletion = (_ success: Bool) -> Void
    func getCards(completion: @escaping CardsCompletion)
    func getMoreCards(completion: @escaping CardsCompletion)
}

//swiftlint:disable identifier_name
struct Token: Decodable {
    var access_token: String = ""
    var token_type: String = ""
    var expires_in: Int = 0
}

final class CardServiceImpl: CardService {
    private let clientId: String  = "ecfdf448c65a4483abac604ec189398d"
    private let clientSecret: String = "7s4pnzEA4E8qhosxH4hru32RyaQzVREQ"
    private let baseURL: String = "https://eu.api.blizzard.com/hearthstone/cards"
    private let locale: String = "en_US" // ru_RU тоже работает, но шрифт не красивый тогда
    private let authURL: String = "https://eu.battle.net/oauth/token"
    private var accessToken: String?
    private var nextPage: Int = 1
    private func toBase64(str: String ) -> String {
        return Data(str.utf8).base64EncodedString()
    }

    func getMoreCards(completion: @escaping CardsCompletion) {
        getCards(completion: completion)
    }

    private func authorise(completion: @escaping AuthCompletion) {
//        let authString = "https://" + clientId + ":" + clientSecret + "@" + authOrigin;
        guard var authComponents = URLComponents(string: authURL) else { return }
        authComponents.queryItems = [
            URLQueryItem(name: "grant_type", value: "client_credentials")
        ]
        guard let authURL = authComponents.url else { return }
        let credetionals: String = clientId+":"+clientSecret
        var request = URLRequest(url: authURL)
        request.httpMethod = "POST"
        request.addValue("Basic "+toBase64(str: credetionals), forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
                completion(false)
                return
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("data: \(dataString)")
                }
            }
            guard let data = data else { return }
            guard let token = try? JSONDecoder().decode(Token.self, from: data) else {
                completion(false)
                return
            }
            self.accessToken = token.access_token
            completion(true)
        }
    .resume()
    }

    func getCards(completion: @escaping CardsCompletion) {
        func authCompletion(success: Bool) {
            if success {
                self.getCards(completion: completion)
            } else {
                print("Authentification error")
            }
        }
        guard accessToken != nil else {
            authorise(completion: authCompletion)
            return
        }
        print("AUTH GOOD")

        guard var requestComponents = URLComponents(string: baseURL) else { return }
        requestComponents.queryItems = [
            URLQueryItem(name: "locale", value: locale),
            URLQueryItem(name: "page", value: String(nextPage)),
            URLQueryItem(name: "pageSize", value: "15"),
            URLQueryItem(name: "access_token", value: accessToken),
            URLQueryItem(name: "collectable", value: "1")
        ]

        guard let requestURL = requestComponents.url else { return }

        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
                completion([])
                return
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                    if response.statusCode == 401 {
                        self.accessToken = ""
                        self.authorise(completion: authCompletion)
                    }
                }
            }
            guard let data = data else {
                print("No data")
                completion([])
                return
            }
            guard let pageData = try? JSONDecoder().decode(Page<Card>.self, from: data) else {
                print("JSON parse error")
                completion([])
                return
            }
            if pageData.pageCount > self.nextPage {
                self.nextPage += 1
            }
            completion(pageData.cards)
        }
        .resume()
//        completion(cards)
    }
}
