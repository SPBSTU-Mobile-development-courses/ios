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
    private var movieId: Int
    private var filmURL: String {
        return "https://api.themoviedb.org/3/movie/\(self.movieId)/credits?api_key=5f8e3e13748f15478401533ce667e66c"
    }
    
    init(withMovieId id: Int) {
        movieId = id
    }
    
    func getData(_ completionHandler: @escaping ([Actor]) -> Void) {
        request(filmURL).responseData {
            switch $0.result {
            case let .success(data):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let credits = try? decoder.decode(CreditsResponse.self, from: data)
                completionHandler(credits?.cast ?? [])
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }
}
