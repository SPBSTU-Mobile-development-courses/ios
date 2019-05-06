//
//  ActorWebViewModel.swift
//  FIlmWiki
//
//  Created by Мария on 19/04/2019.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

class ActorWebViewModel: ActorWebViewModelProtocol {
    private var actorService: ActorServiceNetwork
    private var request: URLRequest? {
        didSet {
            guard let request = request else { return }
            onActorRequestChanged?(request)
        }
    }
    var onActorRequestChanged: ((URLRequest) -> Void)?
    
    init(actorService: ActorServiceNetwork) {
        self.actorService = actorService
    }
    
    func getRequest() {
        actorService.getData { [weak self] requests in
            guard let request = requests.first else { return }
            self?.request = request
        }
    }
}
