//
//  CardFacade.swift
//  Mtg Cards
//
//  Created by Admin on 31.03.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import Foundation
import RealmSwift
//swiftlint:disable:next file_types_order
protocol CardFacade {
    typealias OnUpdateCompletion = ([Card]?) -> Void

    func getCards(completion: @escaping OnUpdateCompletion)
    func loadMore(completion: @escaping OnUpdateCompletion)
}

final class CardFacadeImpl: CardFacade {
    private let cardRepository: CardRepository
    private let cardService: CardService
    private var cardToken: NotificationToken?

    init(cardService: CardService, cardRepository: CardRepository) {
        self.cardRepository = cardRepository
        self.cardService = cardService
    }

    func getCards(completion: @escaping OnUpdateCompletion) {
        cardService.getCards { cards in
            guard let cards = cards else {
                return
            }
            self.cardRepository.save(cards)
        }
        let cards = cardRepository.getCards()
        cardToken = cards.observe { _ in
            completion(cards.map { $0.card })
        }
    }

    func loadMore(completion: @escaping OnUpdateCompletion) {
        cardService.getMoreCards { cards in
            guard let cards = cards else {
                return
            }
            self.cardRepository.save(cards)
            completion(Array(cards))
        }
    }
}
