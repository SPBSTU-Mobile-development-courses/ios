//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Nikita Pinaev on 16.03.2020.
//  Copyright © 2020 Nikita Pinaev. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    let characterService = CharacterService()
    var characters = [Character]()

    override func viewDidLoad() {
        super.viewDidLoad()
        characterService.getCharacters(completion: { (newCharacters) in
            guard let newCharacters = newCharacters else { return }
            self.characters =  newCharacters
            DispatchQueue.main.async {
            self.tableView.reloadData()
            }
        })
//      tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 150
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath)
        guard let characterCell = cell as? CharacterTableViewCell else {
            fatalError("TableView is not configured")
        }
        let characer = characters[indexPath.row]
        characterCell.setup(with: characer)
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == characters.count - 1 else {
            return
        }
        characterService.getMoreCharacters { newCharacters in
            guard let newCharacters = newCharacters else { return }
            self.characters.append(contentsOf: newCharacters)
            DispatchQueue.main.async {
            self.tableView.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            guard let viewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier:
                    "CharacterDetailViewController") as? CharacterDetailViewController else {
                    return
            }
            viewController.character = characters[indexPath.row]
            navigationController?.pushViewController(viewController, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
