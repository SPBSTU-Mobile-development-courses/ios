//
//  ViewController.swift
//  hsCards
//
//  Created by Kirill Chistyakov on 15.03.2020.
//  Copyright © 2020 Kirill Chistyakov. All rights reserved.
//

import UIKit

final class CardViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var acitivityIndicator: UIActivityIndicatorView!
    private var cards = [Card]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private let cellIdentifier = "CardTableViewCell"
    private let cardService: CardService = CardServiceImpl()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg.jpg")!)
        cardService.getCards(completion: {
            guard let cards = $0 else { return }
            self.cards = cards
        })
        tableView.rowHeight = 374
    }
}

extension CardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == cards.count - 1 else { return }
        acitivityIndicator.startAnimating()
        cardService.getMoreCards {
            guard let cards = $0 else { return }
            DispatchQueue.main.async {
                self.acitivityIndicator.stopAnimating()
            }
            self.cards.append(contentsOf: cards)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "CardDetailViewController") as? CardDetailViewController
        else {
            return
        }
        viewController.card = cards[indexPath.row]
        if let cell = tableView.cellForRow(at: indexPath) as? CardTableViewCell, let image = cell.getImage() {
            viewController.image = image
        }
        navigationController?.pushViewController(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true) // снимаем выделение ячейки
    }
}

extension CardViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cards.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CardTableViewCell else {
            fatalError("TableView wasn't configured")
        }
        cell.backgroundColor = .clear
        cell.backgroundView = UIView()
        cell.selectedBackgroundView = UIView()
        let card = cards[indexPath.row]
        cell.setup(card: card, number: indexPath.row + 1)
        return cell
    }
}
