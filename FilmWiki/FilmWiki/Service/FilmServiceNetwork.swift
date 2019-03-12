//
//  StarWarsServiceNetwork.swift
//  StarWarsWiki
//
//  Created by Виталий on 09.03.19.
//  Copyright © 2019 vlad. All rights reserved.
//
import Alamofire
import Foundation

class FilmServiceNetwork: NetworkService {
    var page: Int = 1
    func getData(_ completionHandle: @escaping ([Film]) -> Void) {
        request("https://api.themoviedb.org/3/movie/popular?api_key=5f8e3e13748f15478401533ce667e66c&language=en-US&page=\(page)").responseData {
            switch $0.result {
            case let .success(data):
                let jsonDecoder = JSONDecoder()
                let films : FilmResponse? = try? jsonDecoder.decode(FilmResponse.self, from: data)
                completionHandle(films?.results ?? [])
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }
}
