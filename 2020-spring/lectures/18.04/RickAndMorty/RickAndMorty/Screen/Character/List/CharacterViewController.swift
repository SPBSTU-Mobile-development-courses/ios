//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by Anton Nazarov on 06.03.2020.
//  Copyright © 2020 Anton Nazarov. All rights reserved.
//

import Reusable
import UIKit

final class CharacterViewController: UIViewController, StoryboardBased {
    @IBOutlet private var tableView: UITableView!
    private var characters = [Character]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var characterFacade: CharacterFacade!

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
        let viewController = CharacterDetailViewController.instantiate()
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
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CharacterTableViewCell.self)
        let character = characters[indexPath.row]
        cell.setup(with: character)
        return cell
    }
}
