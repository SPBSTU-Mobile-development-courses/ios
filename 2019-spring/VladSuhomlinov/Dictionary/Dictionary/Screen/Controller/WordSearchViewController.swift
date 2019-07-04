//
//  ViewController.swift
//  Dictionary
//
//  Created by Мария on 20/03/2019.
//  Copyright © 2019 Мария. All rights reserved.
//

import Alamofire
import RealmSwift
import UIKit

class WordSearchViewController: UIViewController {
    @IBOutlet private var wordsTableView: UITableView!
    private var words = [Word]()
    private let searchService = SearchNetworkService()
    private let searchController = UISearchController(searchResultsController: nil)
    private let noWordsMessage = "No word found"
    private let identifierCell = "Cell"
    private let wordService = WordDBService()
    private let reachabilityService = NetworkReachabilityService()
    private var isNoWord: Bool {
        return words.isEmpty && !searchController.isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Type something"
        searchController.searchBar.barTintColor = UIColor.green
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachabilityService)
        reachabilityService.startNotifier()
    }
    
    @objc func reachabilityChanged(note: Notification) {
        guard let reachability = note.object as? NetworkReachabilityService else { return }
        guard !reachability.isNetworkConnected else { return }
        guard searchController.isActive else { return }
        let alert = reachability.getErrorNetworkAlertController { _ in
            self.searchController.isActive = false
        }
        present(alert, animated: true)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return !isNoWord
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let index = self.wordsTableView.indexPathForSelectedRow else { return }
        guard let infoViewController = segue.destination as? InfoWordViewController else { return }
        infoViewController.wordTitle = words[index.row].title
        wordService.addNewWord(SearchedWord(wortTitle: words[index.row].title))
        searchController.searchBar.resignFirstResponder()
    }
    
    deinit {
        reachabilityService.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachabilityService)
    }
}

// MARK: - UITableViewDataSource
extension WordSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isNoWord ? 1 : words.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath)
        cell.textLabel?.text = isNoWord ? noWordsMessage : words[indexPath.row].title
        return cell
    }
}

// MARK: - UISearchResultsUpdating
extension WordSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        NotificationCenter.default.post(name: .reachabilityChanged, object: reachabilityService)
        filterContentForSearchText(searchText)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        cancelRequests()
        guard !searchController.isSearchBarEmpty else {
            self.words.removeAll()
            self.wordsTableView.reloadData()
            return
        }
        self.searchService.word = searchText
        self.searchService.getData { [weak self] words in
            guard let self = self else { return }
            self.words = words ?? []
            DispatchQueue.main.async {
                self.wordsTableView.reloadData()
            }
        }
    }
}

// MARK: - UISearchController
extension UISearchController {
    var isSearchBarEmpty: Bool {
        return searchBar.text?.isEmpty ?? true
    }
}

// MARK: - UISearchControllerDelegate
extension WordSearchViewController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
         self.wordsTableView.isHidden = false
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        self.wordsTableView.isHidden = true
    }
}

// MARK: - Private
private extension WordSearchViewController {
    private func cancelRequests() {
        Alamofire.SessionManager.default.session.getAllTasks { $0.forEach { $0.cancel() } }
    }
}
