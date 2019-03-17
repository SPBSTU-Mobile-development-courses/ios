//
//  ViewController.swift
//  hw1
//
//  Created by Александр Пономарёв on 12/03/2019.
//  Copyright © 2019 Александр Пономарёв. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    private let characterDataNetwork: CharacterService = CharacterDataNetwork()
    private var characters = [Person]()
    // swiftlint:disable:next discouraged_object_literal
    private var avatars = [#imageLiteral(resourceName: "luke"), #imageLiteral(resourceName: "c3po"), #imageLiteral(resourceName: "r2d2"), #imageLiteral(resourceName: "dw"), #imageLiteral(resourceName: "leya"), #imageLiteral(resourceName: "owen"), #imageLiteral(resourceName: "beru"), #imageLiteral(resourceName: "r5d4"), #imageLiteral(resourceName: "biggs"), #imageLiteral(resourceName: "obi.jpeg")]
    private var url: String? = "https://swapi.co/api/people/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        guard let url = url else { return }
        characterDataNetwork.getCharacter(url: url) { [weak self] characters, _ in
            self?.characters.append(contentsOf: characters)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        return
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? DetailViewController else { return }
        guard let cell = sender as? UITableViewCell else { return }
        let indexPathRow = tableView.indexPath(for: cell)?.row
        guard let indexPath = indexPathRow else { return }
        controller.person = characters[indexPath]
        controller.title = characters[indexPath].name
        controller.avatar = avatars[indexPath]
    }
}

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell
        cell?.setupCell(person: characters[indexPath.row], image: avatars[indexPath.row])
        // swiftlint:disable:next force_unwrapping
        return cell!
    }
}
