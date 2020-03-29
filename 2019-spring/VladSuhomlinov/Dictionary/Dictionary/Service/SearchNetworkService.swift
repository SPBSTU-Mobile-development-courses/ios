//
//  SearchNetworkService.swift
//  Dictionary
//
//  Created by Мария on 20/03/2019.
//  Copyright © 2019 Мария. All rights reserved.
//

import Alamofire
import Foundation

class SearchNetworkService: NetworkService {
    var word: String?
    private let limit = 20
    private var searchURL: String {
        let editedWord = word?.replacingOccurrences(of: " ", with: "%20") ?? ""
        return "https://od-api.oxforddictionaries.com:443/api/v1/search/en?q=\(editedWord)&prefix=true&limit=\(limit)"
    }
    private let headers = [ "Accept": "application/json",
                            "app_id": "7300d1cf",
                            "app_key": "4e6507133f3d787e24c57a7619960241"]
    
    func getData(_ completionHandler: @escaping ([Word]?) -> Void) {
        request(searchURL, headers: headers).responseData {
            switch $0.result {
            case let .success(data):
                let words = try? JSONDecoder().decode(WordResponse.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(words?.results)
                }
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }
}
