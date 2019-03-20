//
//  ViewController.swift
//  hw1
//
//  Created by Александр Пономарёв on 12/03/2019.
//  Copyright © 2019 Александр Пономарёв. All rights reserved.
//

import Kingfisher
import RealmSwift
import UIKit

class ViewController: UITableViewController {
    private let characterDataNetwork = CharacterDataNetwork()
    private let realmService = RealmService()
    private lazy var realmPerson = realmService.getAll()
    private let url: String? = "https://rickandmortyapi.com/api/character/"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        guard let url = url else { return }
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self!.characterDataNetwork.getCharacter(url: url) { [weak self] characters, _ in
            if self!.realmPerson.count != 20 {
                    guard let self = self else {
                        return
                    }
                    for characters in characters {
                        self.realmService.add(person: characters)
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
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
        }
    }

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return realmPerson.count
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            fatalError("TableView setup is not correct")
        }
        let realmP = realmPerson[indexPath.row]
        cell.setupCell(name: realmP.name, imageURL: realmP.image)
        return cell
        }
    }
