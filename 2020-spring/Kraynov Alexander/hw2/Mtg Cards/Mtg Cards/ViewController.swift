//
//  ViewController.swift
//  Mtg Cards
//
//  Created by alexander on 07.03.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import DeepDiff
import UIKit

class ViewController: UIViewController {
    private var cards = [Card]()
    private var filteredData = [Card]()
    private let refreshControl = UIRefreshControl()
    private var searchController = UISearchController()
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
            self.filteredData = self.cards
            self.tableView.reloadData()
        }
        tableView.register(cellType: CardTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 350
        setUpSearchController()
    }

    @objc private func refreshTableData() {
        cardFacade.getCards { cardArray in
            guard let cardArray = cardArray else {
                return
            }
            self.cards = cardArray
            self.filteredData = self.cards
            self.tableView.reloadData()
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
            }
        }
    }
    func setUpSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as CardTableViewCell
        let card = filteredData[indexPath.row]
        cell.setup(with: card)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == filteredData.count - 1 && (searchController.searchBar.text == nil) else {
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
        viewController.card = filteredData[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            let buf = filteredData
            filteredData = searchText.isEmpty ? cards : cards.filter { card -> Bool in
                card.name.contains(searchText)
            }
            let changes = diff(old: buf, new: filteredData)
            var deleteIndicies: [IndexPath] = []
            for n in changes {
                guard let deleteIndex = n.delete?.index else {
                    var insertIndicies: [IndexPath] = []
                    for n in changes {
                        guard let insertIndex = n.insert?.index else {
                            return
                        }
                        insertIndicies.append(IndexPath(row: insertIndex, section: 0))
                    }
                    tableView.insertRows(at: insertIndicies, with: .automatic)
                    return
                }
                deleteIndicies.append(IndexPath(row: deleteIndex, section: 0))
            }
            tableView.deleteRows(at: deleteIndicies, with: .fade)

        } else {
            let changes = diff(old: filteredData, new: cards)
            var insertIndicies: [IndexPath] = []
            for n in changes {
                guard let insertIndex = n.insert?.index else {
                    return
                }
                insertIndicies.append(IndexPath(row: insertIndex, section: 0))
            }
            tableView.insertRows(at: insertIndicies, with: .automatic)
        }
    }
}
