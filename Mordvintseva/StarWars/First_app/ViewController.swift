//
//  ViewController.swift
//  First_app
//
//  Created by Mordvintseva Alena on 10/03/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet private var tableView: UITableView!
    private var characters: [Character] = []
    private let characterService = CharacterServiceNetwork()
    private let tableViewCellIdentifier = "tableViewCell"

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let characterViewController = segue.destination as? CharacterViewController else { return }
        guard let cell = sender as? UITableViewCell else { return }
        let characterIndex = tableView.indexPath(for: cell)?.row
        if let characterIndex = characterIndex {
            characterViewController.setCharacter(character: characters[characterIndex])
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        characterService.getCharacters { charactersData in
            self.characters = charactersData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath)
        cell.textLabel?.text = characters[indexPath.row].name
        return cell
    }
}
