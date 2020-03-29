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
    private enum Const {
        static let posterURL = "https://api.themoviedb.org/3/movie/popular?api_key=5f8e3e13748f15478401533ce667e66c&language=en-US&page="
    }
    private var page: Int = 1
    
    func getData(_ completionHandler: @escaping ([Film]) -> Void) {
        request(Const.posterURL + "\(page)").responseData {
            switch $0.result {
            case let .success(data):
                let films = try? JSONDecoder().decode(FilmResponse.self, from: data)
                self.page += 1
                completionHandler(films?.results ?? [])
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }
}
