//
//  ViewController.swift
//  RickAndMorty
//
//  Created by user on 22.04.2020.
//  Copyright © 2020 ulkoart. All rights reserved.
//

import RealmSwift
import UIKit

class TableVC: UIViewController {

    @IBOutlet private var tableView: UITableView!

    let characterFacade = CharacterFacadeImpl()
    var characters = [Character]()
    private let refreshControl = UIRefreshControl()
    let footerSpinner = UIActivityIndicatorView(style: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // tableView.rowHeight = UITableView.automaticDimension
        tableView.rowHeight = 110
        tableView.refreshControl = refreshControl
        tableView.tableFooterView = footerSpinner
        refreshControl.addTarget(self, action: #selector(refreshCharacters(_:)), for: .valueChanged)
        loadCharacters()

    }

    @objc private func refreshCharacters(_ sender: Any) {
        loadCharacters()
    }

    private func loadCharacters() {
        refreshControl.beginRefreshing()
        characterFacade.getCharacters { characters in
            self.characters = characters
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
}

extension TableVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as? CharacterTableViewCell else {
            fatalError("TableView wasn't configured")
        }
        let character = characters[indexPath.row]
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
        viewController.character = characters[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)

    }
}
