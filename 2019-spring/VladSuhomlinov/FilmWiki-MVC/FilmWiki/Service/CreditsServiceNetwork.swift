//
//  CreditorsServiceNetwork.swift
//  StarWarsWiki
//
//  Created by Виталий on 11.03.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Alamofire
import Foundation

class CreditsServiceNetwork: NetworkService {
    var movieId: Int?
    
    func getData(_ completionHandler: @escaping ([Actor]) -> Void) {
        guard let movieId = self.movieId else { return }
        request("https://api.themoviedb.org/3/movie/\(movieId)/credits?api_key=5f8e3e13748f15478401533ce667e66c").responseData {
            switch $0.result {
            case let .success(data):
                let credits = try? JSONDecoder().decode(CreditsResponse.self, from: data)
                completionHandler(credits?.cast ?? [])
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }
}
