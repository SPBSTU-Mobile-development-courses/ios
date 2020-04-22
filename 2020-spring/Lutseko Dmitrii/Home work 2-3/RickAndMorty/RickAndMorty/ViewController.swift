//
//  ViewController.swift
//  RickAndMorty
//
//  Created by user167844 on 3/23/20.
//  Copyright © 2020 Dmitrii Lutsenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet private var tableView: UITableView!
    let characterService = CharacterService()
    var characters = [Character]()
    override func viewDidLoad() {
        super.viewDidLoad()
        characterService.getCharacters(completion: {(newCharacters) in
            guard let newCharacters = newCharacters else { return }
            self.characters = newCharacters
            DispatchQueue.main.async {
                 self.tableView.reloadData()
            }
        })
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath)
        guard let characterCell = cell as? CharacterTableViewCell
            else {
            fatalError("Table view is not configured")
        }
        let character = characters[indexPath.row]
       // characterCell.label?.text = character.name
        characterCell.setup(with: character)
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == characters.count - 1 else { return }
        characterService.getMoreCharacters { newCharacters in
            guard let newCharacters = newCharacters else { return }
            self.characters.append(contentsOf: newCharacters)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
