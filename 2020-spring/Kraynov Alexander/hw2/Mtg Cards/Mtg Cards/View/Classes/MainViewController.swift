//
//  ViewController.swift
//  Mtg Cards
//
//  Created by alexander on 07.03.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var filteredData = [Card]()
    private let refreshControl = UIRefreshControl()
    private var searchController = UISearchController()
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var presenter: MainViewPresenter!
    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainViewPresenter(view: self)
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshTableData), for: .valueChanged)
        tableView.register(cellType: CardTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 350
        setUpSearchController()
    }

    @objc private func refreshTableData() {
        presenter.getCards { _ in
            self.tableView.reloadData()
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
            }
        }
    }

    func reloadTableView() {
        tableView.reloadData()
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

extension MainViewController: UITableViewDataSource {
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

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row >= filteredData.count - 1 && (searchController.searchBar.text?.isEmpty ?? true) else {
            return
        }
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

        self.tableView.tableFooterView = spinner
        spinner.hidesWhenStopped = true
        presenter.loadMore {_ in
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

extension MainViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ??  ""
        let buf = filteredData
        filteredData = presenter.filter(with: searchText)
        let changes = presenter.getDiff(old: filteredData, new: buf)
        if !changes.0.isEmpty {
            tableView.deleteRows(at: changes.0, with: .fade)
        }
        if !changes.1.isEmpty {
            tableView.insertRows(at: changes.1, with: .fade)
        }
    }
}
