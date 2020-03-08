//
//  ViewController.swift
//  Mtg Cards
//
//  Created by alexander on 07.03.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    private var cards = [Card]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private let cardService: CardService = CardServiceImpl()
    private let cellIdentifier = "CardTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        cardService.getCards { cardArray in
            guard let cardArray = cardArray else {
                return
            }
            self.cards = cardArray
        }
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CardTableViewCell else {
            fatalError("TableView wasn't configured")
        }
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
        guard let viewController =  UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "CardDetailViewController") as? CardDetailViewController else {
                return
        }
        viewController.card = cards[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

