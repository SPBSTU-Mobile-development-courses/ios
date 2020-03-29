//
//  ViewController.swift
//  Mtg Cards
//
//  Created by alexander on 07.03.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var cards = [Card]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private let cardService: CardService = CardServiceImpl()
    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        cardService.getCards { cardArray in
            guard let cardArray = cardArray else {
                return
            }
            self.cards = cardArray
        }
        tableView.register(cellType: CardTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 350
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cards.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as CardTableViewCell
        let card = cards[indexPath.row]
        cell.setup(with: card)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == cards.count - 1 else {
            return
        }
        cardService.getMoreCards { cardArray in
            guard let cards = cardArray else {
                return
            }
            self.cards.append(contentsOf: cards)
        }
    }
    func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = CardDetailViewController.instantiate() as CardDetailViewController
        viewController.card = cards[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
