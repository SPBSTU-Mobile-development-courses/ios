//
//  FavouritesViewController.swift
//  Dictionary
//
//  Created by Мария on 29/03/2019.
//  Copyright © 2019 Мария. All rights reserved.
//

import RealmSwift
import UIKit

class FavouritesViewController: UIViewController {
    @IBOutlet private var favouritesTableView: UITableView!
    @IBOutlet private var deleteFavouriteButton: UIBarButtonItem!
    private let wordService = WordDBService()
    private lazy var words = wordService.getAllWords(forType: FavouriteWord.self)
    private let identifier = "favouriteCell"
    private var observer: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observer = words.observe { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.favouritesTableView.reloadData()
            }
            self.deleteFavouriteButton.isEnabled = !self.words.isEmpty
        }
    }
    
    deinit {
        observer?.invalidate()
    }
    
    @IBAction private func deleteAllFavourites(_ sender: UIButton) {
        let alert = UIAlertController(title: "Delete all favourites?", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        let addAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.wordService.deleteAll(ofType: FavouriteWord.self)
        }
        alert.addAction(addAction)
        present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let index = self.favouritesTableView.indexPathForSelectedRow else { return }
        guard let infoViewController = segue.destination as? InfoWordViewController else { return }
        infoViewController.wordTitle = words[index.row].wordTitle
    }
}

// MARK: - UITableViewDataSource
extension FavouritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = words[indexPath.row].wordTitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        wordService.delete(word: words[indexPath.row])
    }
}
