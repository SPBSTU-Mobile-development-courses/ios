//
//  FilmsList.swift
//  FIlmWiki
//
//  Created by Мария on 19/04/2019.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

class FilmViewModel: FilmViewModelProtocol {
    private let filmService: FilmServiceNetwork
    private var films = [Film]() {
        didSet {
            onFilmsAppended?(films)
        }
    }
    var onFilmsAppended: (([Film]) -> Void)?
    
    init(filmService: FilmServiceNetwork) {
        self.filmService = filmService
    }
    
    func loadMore() {
        filmService.getData { [weak self] films in
            guard let self = self else { return }
            self.films = films
        }
    }
}
