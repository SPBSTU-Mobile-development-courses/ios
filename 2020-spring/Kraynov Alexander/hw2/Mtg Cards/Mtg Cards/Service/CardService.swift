//
//  CardService.swift
//  Mtg Cards
//
//  Created by alexander on 07.03.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import Foundation

protocol CardService {
    typealias CardCompletion = ([Card]?) -> Void
    func getCards(completion: @escaping CardCompletion)
    func getMoreCards(completion: @escaping CardCompletion)
}
