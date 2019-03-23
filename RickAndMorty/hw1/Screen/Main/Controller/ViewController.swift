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

class ViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    private let characterDataNetwork = CharacterDataNetwork()
    private let realmService = RealmService()
    private lazy var realmPerson = realmService.getAll()
    private let url: String? = "https://rickandmortyapi.com/api/character/"
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        tableView.register(UINib(nibName: "TestTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        guard let url = url else { return }
        self.characterDataNetwork.getCharacter(url: url) { [weak self] characters, _ in
            if self!.realmPerson.count != 20 {
                guard let self = self else { return }
                for characters in characters {
                    self.realmService.add(person: characters)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        return
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return realmPerson.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        self.navigationController?.pushViewController(detailVC, animated: true)
        detailVC.title = realmPerson[indexPath.row].name
        detailVC.realmPerson = realmPerson[indexPath.row]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TestTableViewCell else {
            fatalError("TableView setup is not correct!")
        }
        let realmP = realmPerson[indexPath.row]
        cell.setupCell(name: realmP.name, imageURL: realmP.image)
        return cell
    }
}
