//
//  HistoryViewController.swift
//  Dictionary
//
//  Created by Мария on 26/03/2019.
//  Copyright © 2019 Мария. All rights reserved.
//

import RealmSwift
import UIKit

class HistoryViewController: UIViewController {
    @IBOutlet private var historyTableView: UITableView!
    @IBOutlet private var deleteHistoryButton: UIBarButtonItem!
    private let wordService = WordDBService()
    private lazy var words = wordService.getAllWords(forType: SearchedWord.self)
    private let identifier = "Cell"
    private var observer: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observer = words.observe { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.historyTableView.reloadData()
            }
            self.deleteHistoryButton.isEnabled = !self.words.isEmpty
        }
    }
    
    deinit {
        observer?.invalidate()
    }
    
    @IBAction private func deleteAllHistory(_ sender: UIButton) {
        let alert = UIAlertController(title: "Delete all history?", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        let addAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.wordService.deleteAll(ofType: SearchedWord.self)
        }
        alert.addAction(addAction)
        present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let index = self.historyTableView.indexPathForSelectedRow else { return }
        guard let infoViewController = segue.destination as? InfoWordViewController else { return }
        infoViewController.wordTitle = words[index.row].wordTitle
    }
}

// MARK: - UITableViewDataSource
extension HistoryViewController: UITableViewDataSource {
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
