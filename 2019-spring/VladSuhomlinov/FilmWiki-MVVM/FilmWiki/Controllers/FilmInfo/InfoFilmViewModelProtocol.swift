//
//  InfoFilmViewModelProtocol.swift
//  FIlmWiki
//
//  Created by Мария on 25/04/2019.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

protocol InfoFilmViewModelProtocol {
    var onActorsChanged: (([Actor]) -> Void)? { get set }
    var onActorsNotUploaded: (() -> Void)? { get set }
    
    func loadMore()
}
