//
//  InfoFilmViewModel.swift
//  FIlmWiki
//
//  Created by Мария on 19/04/2019.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

class InfoFilmViewModel<Service> where Service: NetworkService {
    private let infoFilmService: Service
    private var actors = [Actor]() {
        didSet {
            onActorsChanged?(actors)
        }
    }
    var onActorsChanged: (([Actor]) -> Void)?
    
    init(infoFilmService: Service) {
        self.infoFilmService = infoFilmService
    }
    
    func loadMore() {
        infoFilmService.getData { [weak self] actors in
            guard let self = self else { return }
            guard let actors = actors as? [Actor] else { return }
            self.actors = actors
        }
    }
}
