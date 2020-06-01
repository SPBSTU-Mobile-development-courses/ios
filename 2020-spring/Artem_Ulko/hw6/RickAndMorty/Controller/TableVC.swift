//
//  ViewController.swift
//  RickAndMorty
//
//  Created by user on 22.04.2020.
//  Copyright © 2020 ulkoart. All rights reserved.
//

import DeepDiff
import RealmSwift
import UIKit

class TableVC: UIViewController {

    @IBOutlet private var tableView: UITableView!

    var characterFacade: CharacterFacade!
    private var characters = [Character]()
    private var filteredCharacters = [Character]()
    private let refreshControl = UIRefreshControl()
    private let footerSpinner = UIActivityIndicatorView(style: .gray)
    private let searchController = UISearchController(searchResultsController: nil)
    private var isSearching = false
    private var isSearchBarEmpty: Bool {
        searchController.searchBar.text?.isEmpty ?? true
    }
    private var isFiltering: Bool {
        searchController.isActive && !isSearchBarEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 110
        tableView.refreshControl = refreshControl
        tableView.tableFooterView = footerSpinner
        refreshControl.addTarget(self, action: #selector(refreshCharacters(_:)), for: .valueChanged)
        setUpSearchController()
        loadCharacters()

    }

    private func setUpSearchController() {
        searchController.searchBar.placeholder = "Search characters"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }

    @objc private func refreshCharacters(_ sender: Any) {
        loadCharacters()
    }

    private func loadCharacters() {
        refreshControl.beginRefreshing()
        characterFacade.getCharacters { [weak self] characters in // [weak self] - слабая ссылка, чтоб не было зацикливания и память не потекла
            self?.characters = characters
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
    }

}

extension TableVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCharacters.count
        }

        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as? CharacterTableViewCell else {
            fatalError("TableView wasn't configured")
        }
        let character: Character = isFiltering ? filteredCharacters[indexPath.row] : characters[indexPath.row] // так еще лучше будет :)
        cell.setup(with: character)
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == characters.count - 1 else { return }
        footerSpinner.startAnimating()
        characterFacade.loadMore {
            DispatchQueue.main.async {
                self.footerSpinner.stopAnimating()
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else {
                return
        }
        let character: Character
        if isFiltering {
            character = filteredCharacters[indexPath.row]
        } else {
            character = characters[indexPath.row]
        }
        viewController.character = character
        navigationController?.pushViewController(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)

    }

}

extension TableVC: UISearchResultsUpdating {
    func filterContentForSearchText(searchText: String) {

        let newFilteredCharacters = characters.filter { (character: Character) -> Bool in
            character.name.lowercased().contains(searchText.lowercased())
        }

        let changes = diff(old: filteredCharacters, new: newFilteredCharacters)
        tableView.reload(
            changes: changes,
            section: 0,
            replacementAnimation: UITableView.RowAnimation.none,
            updateData: ({ filteredCharacters = newFilteredCharacters })
        )

    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if !isSearching {
            filteredCharacters = characters
            isSearching = true
        }
        if searchController.isBeingDismissed {
            isSearching = false
            let changes = diff(old: filteredCharacters, new: characters)
            tableView.reload(
                changes: changes,
                section: 0,
                replacementAnimation: UITableView.RowAnimation.none,
                updateData: ({ filteredCharacters = [] })
            )
        }
        guard !text.isEmpty else { return }
        filterContentForSearchText(searchText: text)
    }
}
