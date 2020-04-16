//
//  ViewController.swift
//  Memes
//
//  Created by panandafog on 20.03.2020.
//  Copyright © 2020 panandafog. All rights reserved.
//

import DeepDiff
import SwiftTryCatch
import UIKit

class ViewController: UIViewController {
    private let memeFacade: MemeFacade = MemeFacadeImpl(memeService: MemeService(), memeRepository: MemeRepositoryImpl())
    private let activity = UIActivityIndicatorView()
    private let searchController = UISearchController(searchResultsController: nil)
    private let service = MemeService()
    private var posts = [Post]()
    private var filteredPosts = [Post]()
    private var isSearching = false

    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        MemeCell.viewController = self
        memeFacade.getMemes(completion: { newMemes in
            guard let newMemes = newMemes else { return }
            self.posts = newMemes
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search in memebase"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = ["Title", "Tag"]
        searchController.searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 400
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        tableView.tableFooterView = activity
    }

    @objc func handleRefreshControl() {
        memeFacade.getRepository().clear()
        memeFacade.getMemes(completion: { newMemes in
            guard let newMemes = newMemes else { return }
            self.posts = newMemes
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        tableView.refreshControl?.endRefreshing()
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredPosts.count
        }
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell", for: indexPath) as? MemeCell else {
            fatalError("Table view is not configured")
        }
        var post: Post

        if isFiltering {
            post = filteredPosts[indexPath.row]
        } else {
            post = posts[indexPath.row]
        }

        cell.setup(with: post, controller: self, index: indexPath)
        if !activity.isAnimating { activity.startAnimating() }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == posts.count - 1 else { return }
        memeFacade.loadMore()
        activity.stopAnimating()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
                return
        }

        var post: Post

        if isFiltering {
            post = filteredPosts[indexPath.row]
        } else {
            post = posts[indexPath.row]
        }

        viewController.post = post
        navigationController?.present(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController {
    func updateCell(row: Int, section: Int) {
        tableView.reloadRows(at: [IndexPath(row: row, section: section)], with: .automatic)
    }
    func updateCells() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

// MARK: - UISearchResultsUpdating Delegate
extension ViewController: UISearchResultsUpdating {
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }

    private var isFiltering: Bool {
        searchController.isActive
    }

    private func filterContentForSearchText(_ searchText: String, scope: String = "Title") {
        let newFilteredPosts = posts.filter({ (post: Post) -> Bool in
            if scope == "Title" {
                return post.title.lowercased().contains(searchText.lowercased())
            }
            return post.tagsNames.lowercased().contains(searchText.lowercased())
        })
        let changes = diff(old: filteredPosts, new: newFilteredPosts)

        self.tableView.reload(changes: changes, section: 0, replacementAnimation: UITableView.RowAnimation.none, updateData: {
                        self.filteredPosts = newFilteredPosts
        })
    }

    func updateSearchResults(for searchController: UISearchController) {
        if !isSearching {
            filteredPosts = posts
            isSearching = true
        }
        if !searchController.isActive {
            if searchController.isBeingDismissed {
                isSearching = false
                let changes = diff(old: filteredPosts, new: posts)
                self.tableView.reload(changes: changes, section: 0, replacementAnimation: UITableView.RowAnimation.none, updateData: {
                    self.filteredPosts = []
                })
            }
            return
        }
        guard let bar = searchController.searchBar.text else { return }
        let searchBar = searchController.searchBar
        guard let scope = searchBar.scopeButtonTitles?[searchBar.selectedScopeButtonIndex] else { return }
        filterContentForSearchText(bar, scope: scope)
    }
}

// MARK: - UISearchBar Delegate
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        guard let bar = searchController.searchBar.text else { return }
        guard let scope = searchBar.scopeButtonTitles?[selectedScope] else { return }
        filterContentForSearchText(bar, scope: scope)
    }
}
