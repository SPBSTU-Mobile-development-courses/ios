//
//  WordNetworkService.swift
//  Dictionary
//
//  Created by Мария on 21/03/2019.
//  Copyright © 2019 Мария. All rights reserved.
//

import Alamofire
import Foundation

class WordNetworkService: NetworkService {
    var wordTitle: String?
    private var infoURL: String {
        return "https://od-api.oxforddictionaries.com:443/api/v1/entries/en/\(wordTitle?.replacingOccurrences(of: " ", with: "%20") ?? "")"
    }
    private let headers = [ "Accept": "application/json",
                            "app_id": "7300d1cf",
                            "app_key": "4e6507133f3d787e24c57a7619960241"]
    
    func getData(_ completionHandler: @escaping ([Word]?) -> Void) {
        request(infoURL, headers: headers).responseData {
            switch $0.result {
            case let .success(data):
                let entities = try? JSONDecoder().decode(WordResponse.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(entities?.results)
                }
            case let .failure(error):
                print("Error: \(error)")
                completionHandler(nil)
            }
        }
    }
}
