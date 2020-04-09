//
//  CardRepository.swift
//  Mtg Cards
//
//  Created by Admin on 31.03.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import Foundation
import RealmSwift

protocol CardRepository {
    func save (_ characters: [Card])
    func getCards() -> Results<CardRealm>
}
