//
//  ActorWebViewModelProtocol.swift
//  FIlmWiki
//
//  Created by Мария on 25/04/2019.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

protocol ActorWebViewModelProtocol {
    var onActorRequestChanged: ((URLRequest) -> Void)? { get set }
    
    func getRequest()
}
