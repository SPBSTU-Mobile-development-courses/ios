//
//  FilmsList.swift
//  FIlmWiki
//
//  Created by Мария on 19/04/2019.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

class FilmViewModel<Service> where Service: NetworkService {
    private let filmService: Service
    private var films = [Film]() {
        didSet {
            onFilmsChanged?(films)
        }
    }
    var onFilmsChanged: (([Film]) -> Void)?
    
    init(filmService: Service) {
        self.filmService = filmService
    }
    
    func loadMore() {
        filmService.getData { [weak self] films in
            guard let self = self else { return }
            guard let films = films as? [Film] else { return }
            self.films = films
        }
    }
}
