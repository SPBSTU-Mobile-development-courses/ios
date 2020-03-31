//
//  CardRepository.swift
//  Mtg Cards
//
//  Created by Admin on 31.03.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import Foundation
import RealmSwift

//swiftlint:disable:next file_types_order
protocol CardRepository {
    func save (_ characters: [Card])
    func getCards() -> Results<CardRealm>
}

final class CardRepositoryImpl: CardRepository {
    var realm: Realm {
        do {
            return try Realm()
        } catch {
            fatalError("Realm can't be created")
        }
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
