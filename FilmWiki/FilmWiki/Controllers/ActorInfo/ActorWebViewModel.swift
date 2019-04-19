//
//  ActorWebViewModel.swift
//  FIlmWiki
//
//  Created by Мария on 19/04/2019.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

class ActorWebViewModel<Service> where Service: NetworkService {
    private var actorService: Service
    private var request: URLRequest? {
        didSet {
            guard let request = request else { return }
            onActorRequestChanged?(request)
        }
    }
    var onActorRequestChanged: ((URLRequest) -> Void)?
    
    init(actorService: Service) {
        self.actorService = actorService
    }
    
    func getRequest() {
        actorService.getData { [weak self] requests in
            guard let request = requests.first as? URLRequest else { return }
            self?.request = request
        }
    }
}
