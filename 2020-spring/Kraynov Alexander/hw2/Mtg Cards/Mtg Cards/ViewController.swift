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
    private let refreshControl = UIRefreshControl()
    private let cardFacade: CardFacade = CardFacadeImpl(cardService: CardServiceImpl(), cardRepository: CardRepositoryImpl())
    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshTableData), for: .valueChanged)
        cardFacade.getCards { cardArray in
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

    @objc private func refreshTableData(_: Any) {
        cardFacade.getCards { cardArray in
            guard let cardArray = cardArray else {
                return
            }
            self.cards = cardArray
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
            }
        }
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
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

        self.tableView.tableFooterView = spinner
        spinner.hidesWhenStopped = true
        cardFacade.loadMore {_ in
            DispatchQueue.main.async {
                spinner.stopAnimating()
            }
        }
    }

    func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = CardDetailViewController.instantiate() as CardDetailViewController
        viewController.card = cards[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
