//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by Anton Nazarov on 06.03.2020.
//  Copyright © 2020 Anton Nazarov. All rights reserved.
//

import UIKit

final class CharacterViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    private var characters = [Character]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private let characterFacade: CharacterFacade = CharacterFacadeImpl(
        characterService: CharacterServiceImpl(), characterRepository: CharacterRepositoryImpl()
    )
    private let cellIdentifier = "CharacterTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        characterFacade.getCharacters {
            guard let characters = $0 else { return }
            self.characters = characters
        }
        tableView.rowHeight = 120
    }
}

// MARK: - UITableViewDelegate
extension CharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == characters.count - 1 else { return }
        characterFacade.loadMore()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "CharacterDetailViewController") as? CharacterDetailViewController else {
                return
        }
        viewController.character = characters[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension CharacterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CharacterTableViewCell else {
            fatalError("TableView wasn't configured")
        }
        let character = characters[indexPath.row]
        cell.setup(with: character)
        return cell
    }
}
