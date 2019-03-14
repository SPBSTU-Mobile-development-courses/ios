//
//  ViewController.swift
//  First_app
//
//  Created by Mordvintseva Alena on 10/03/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var loadingView: UIView!
    @IBOutlet private var emptyView: UIView!
    private var nextPageURL: String? = "https://swapi.co/api/people/"
    private var characters: [Character] = []
    private let characterService = CharacterServiceNetwork()
    private let tableViewCellIdentifier = "tableViewCell"

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let characterViewController = segue.destination as? CharacterViewController else { return }
        guard let cell = sender as? UITableViewCell else { return }
        let characterIndex = tableView.indexPath(for: cell)?.row
        if let characterIndex = characterIndex {
            characterViewController.setCharacter(character: characters[characterIndex])
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadNextPage()
    }

    func loadNextPage() {
        guard let nextPage = nextPageURL else {
            return
        }

        tableView.tableFooterView = loadingView
        characterService.getCharacters(urlString: nextPage) { charactersData in
            self.characters.append(contentsOf: charactersData.results)
            self.nextPageURL = charactersData.next
            DispatchQueue.main.async {
                self.tableView.tableFooterView = self.emptyView
                self.tableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath)
        if indexPath.row == self.characters.count - 1, nextPageURL != nil {
            loadNextPage()
        }

        cell.textLabel?.text = characters[indexPath.row].name
        return cell
    }
}
