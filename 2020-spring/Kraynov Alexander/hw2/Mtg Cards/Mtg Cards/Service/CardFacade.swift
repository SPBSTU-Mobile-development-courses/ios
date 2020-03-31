//
//  CardFacade.swift
//  Mtg Cards
//
//  Created by Admin on 31.03.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import Foundation

protocol CardFacade {
    typealias OnUpdateCompletion = ([Card]?) -> Void

    func getCards(completion: @escaping OnUpdateCompletion)
    func loadMore(completion: @escaping OnUpdateCompletion)
}
