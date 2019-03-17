//
//  ViewController.swift
//  hw1
//
//  Created by Александр Пономарёв on 12/03/2019.
//  Copyright © 2019 Александр Пономарёв. All rights reserved.
//

import RealmSwift
import UIKit

class ViewController: UITableViewController {
    private let characterDataNetwork: CharacterService = CharacterDataNetwork()
    private var characters = [Person]()
    private let realmService = RealmService()
    private lazy var realmPerson = realmService.getAll()
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
        controller.realmPerson = realmPerson[indexPath]
        controller.title = realmPerson[indexPath].name
        controller.avatar = avatars[indexPath]
    }
}

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if characters.count > realmPerson.count {
            return characters.count
        } else {
            return realmPerson.count
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            fatalError("TableView setup is not correct")
        }
        if realmPerson.count != 10 {
            cell.setupCell(name: characters[indexPath.row].name, image: avatars[indexPath.row])
            self.realmService.add(name: characters[indexPath.row].name, height: characters[indexPath.row].height)
        } else {
            cell.setupCell(name: self.realmPerson[indexPath.row].name, image: self.avatars[indexPath.row])
        }
        return cell
    }
}
