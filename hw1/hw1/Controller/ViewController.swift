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
    private var logoImages = [UIImage(named: "luke.jpg")!,
                              UIImage(named: "c3po.jpg")!,
                              UIImage(named: "r2d2.jpg")!,
                              UIImage(named: "dw.jpg")!,
                              UIImage(named: "leya.jpg")!,
                              UIImage(named: "owen.png")!,
                              UIImage(named: "beru.png")!,
                              UIImage(named: "r5d4.jpg")!,
                              UIImage(named: "biggs.jpg")!,
                              UIImage(named: "obi.jpeg")!,]
    private var url: String? = "https://swapi.co/api/people/"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.rowHeight = 100
        guard let url = url else {
            return
        }
        characterDataNetwork.getCharacter(url: url) { characters, url in
            for newCharacter in characters {
                self.characters.append(newCharacter)
            }
            self.url = url
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        return
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? DetailViewController else { return }
            guard let cell = sender as? UITableViewCell else { return }
            let indexPathRow = tableView.indexPath(for: cell)?.row
            if let indexPath = indexPathRow {
                controller.people = characters[indexPath]
                controller.title = characters[indexPath].name
                controller.avatar = logoImages[indexPath]
            }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell
        cell?.nameLabel?.text = characters[indexPath.row].name
        cell?.avatarView?.image = logoImages[indexPath.row]
        //swiftlint:disable:next force_cast
        return cell!
    }
}
