//
//  CardRepositoryImpl.swift
//  Mtg Cards
//
//  Created by Admin on 31.03.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import Foundation
import RealmSwift

final class CardRepositoryImpl: CardRepository {
    private let configuration: Realm.Configuration
    var realm: Realm {
        do {
            return try Realm(configuration: configuration)
        } catch {
            fatalError("Realm can't be created")
        }
    }

    init(configuration: Realm.Configuration = .defaultConfiguration) {
        self.configuration = configuration
    }

    func save(_ cards: [Card]) {
        let cards = cards.map(CardRealm.init(card: ))
        try? realm.write {
            realm.add(cards, update: .modified)
        }
    }
    func getCards() -> Results<CardRealm> {
        realm.objects(CardRealm.self)
    }
}
