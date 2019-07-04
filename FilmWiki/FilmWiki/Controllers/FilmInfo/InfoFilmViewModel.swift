//
//  InfoFilmViewModel.swift
//  FIlmWiki
//
//  Created by Мария on 19/04/2019.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

class InfoFilmViewModel: InfoFilmViewModelProtocol {
    private let infoFilmService: CreditsServiceNetwork
    private var actors = [Actor]() {
        didSet {
            onActorsChanged?(actors)
        }
    }
    var onActorsChanged: (([Actor]) -> Void)?
    var onActorsNotUploaded: (() -> Void)?
    
    init(infoFilmService: CreditsServiceNetwork) {
        self.infoFilmService = infoFilmService
    }
    
    func loadMore() {
        infoFilmService.getData { [weak self] actors in
            guard let self = self else { return }
            guard !actors.isEmpty else {
                self.onActorsNotUploaded?()
                return
            }
            self.actors = actors
        }
    }
}
