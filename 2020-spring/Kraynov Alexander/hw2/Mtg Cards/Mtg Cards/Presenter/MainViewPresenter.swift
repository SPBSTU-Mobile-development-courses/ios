//
//  MainViewPresenter.swift
//  Mtg Cards
//
//  Created by Admin on 22.04.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import DeepDiff
import UIKit

class MainViewPresenter {
    typealias OnUpdateCompletion = ([Card]?) -> Void

    private var cards = [Card]()
    private let view: MainViewController
    private let cardFacade: CardFacade

    init(view: MainViewController, facade: CardFacade = CardFacadeImpl(cardService: CardServiceImpl(), cardRepository: CardRepositoryImpl())) {
        self.view = view
        self.cardFacade = facade
        cardFacade.getCards { cardArray in
            guard let cardArray = cardArray else {
                return
            }
            self.cards = cardArray
            view.filteredData = self.cards
            view.reloadTableView()
        }
    }

    func getCards(completion: @escaping OnUpdateCompletion) {
        cardFacade.getCards { cardArray in
            guard let cardArray = cardArray else {
                return
            }
            self.cards = cardArray
            self.view.filteredData = self.cards
            completion(self.cards)
        }
    }

    func loadMore(completion: @escaping OnUpdateCompletion) {
        cardFacade.loadMore(completion: completion)
    }

    func getDiff(old: [Card], new: [Card]) -> ([IndexPath], [IndexPath]) {
        let differences = diff(old: old, new: new)
        var deletions = [IndexPath]()
        var insertions = [IndexPath]()
        for difference in differences {
            if let deletion = difference.delete?.index {
                deletions.append(IndexPath(row: deletion, section: 0))
            }
            if let insertion = difference.insert?.index {
                insertions.append(IndexPath(row: insertion, section: 0))
            }
        }
       return (insertions, deletions)
    }

    func filter(with query: String) -> [Card] {
        if query.isEmpty {
            return cards
        } else {
            return cards.filter {
                $0.name.lowercased().contains(query.lowercased())
            }
        }
    }
}
