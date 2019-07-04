//
//  InfoWordViewController.swift
//  Dictionary
//
//  Created by Мария on 21/03/2019.
//  Copyright © 2019 Мария. All rights reserved.
//

import Reachability
import RealmSwift
import UIKit

class InfoWordViewController: UIViewController {
    @IBOutlet private var infoWordTableView: UITableView!
    @IBOutlet private var favouriteButton: UIBarButtonItem!
    private let wordInfoService = WordNetworkService()
    private var word: Word?
    private let identifierCell = "infoCell"
    private let identifierHeader = "headerInfo"
    private let wordService = WordDBService()
    // swiftlint:disable force_unwrapping
    private let reachability = Reachability()!
    var wordTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordInfoService.wordTitle = wordTitle
        infoWordTableView.tableFooterView = UIView()
        infoWordTableView.register(UINib(nibName: "InfoTableViewCell", bundle: nil), forCellReuseIdentifier: identifierCell)
        infoWordTableView.register(UINib(nibName: "WordHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: identifierHeader)
        getWordData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        favouriteButton.tintColor = wordService.checkFavouriteWord(withTitle: wordTitle) ? .red : .lightGray
    }
    
    @IBAction private func clickedFavouriteButton(_ sender: UIBarButtonItem) {
        guard let tempWord = wordService.getFavouriteWord(withTitle: wordTitle) else {
            wordService.addNewWord(FavouriteWord(wordTitle: wordTitle, isFavourite: true))
            favouriteButton.tintColor = .red
            return
        }
        favouriteButton.tintColor = .lightGray
        wordService.delete(word: tempWord)
    }
    
    // MARK: - Private
    private func getWordData() {
        wordInfoService.getData { [weak self] words in
            guard let self = self else { return }
            guard let words = words else {
                self.getErrorNetworkMessage()
                return
            }
            self.word = words.first
            DispatchQueue.main.async {
                self.infoWordTableView.reloadData()
            }
        }
    }
    
    private func getErrorNetworkMessage() {
        let alert = NetworkReachabilityService().getErrorNetworkAlertController { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension InfoWordViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rowsCount = word?.lexicalEntries?[section].entries?.first?.senses?.count else {
            return 0
        }
        return rowsCount
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let rowsCount = word?.lexicalEntries?.count else {
            return 0
        }
        return rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath) as? InfoTableViewCell else { return UITableViewCell() }
        let sense = self.word?.lexicalEntries?[indexPath.section].entries?.first?.senses?[indexPath.row]
        cell.setCellAt(indexPath: indexPath, with: sense)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension InfoWordViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifierHeader) as? WordHeaderView else { return nil }
        let entry = self.word?.lexicalEntries?[section]
        headerView.entry = entry
        return headerView
    }
}
