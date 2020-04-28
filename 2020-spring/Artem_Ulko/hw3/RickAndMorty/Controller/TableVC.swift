//
//  ViewController.swift
//  RickAndMorty
//
//  Created by user on 22.04.2020.
//  Copyright © 2020 ulkoart. All rights reserved.
//

import UIKit

class TableVC: UIViewController {

    @IBOutlet private var tableView: UITableView!

    let characterService = CharacterService()
    var characters = [Character]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.rowHeight = UITableView.automaticDimension
        tableView.rowHeight = 110
        characterService.getCharacters { characters in
            self.characters = characters

            DispatchQueue.main.async {
                self.tableView.reloadData()
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
        guard indexPath.row == characters.count - 1 else {
            return
        }

        characterService.getMoreCharacters { characters in
            self.characters.append(contentsOf: characters)

            DispatchQueue.main.async {
                self.tableView.reloadData()
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
