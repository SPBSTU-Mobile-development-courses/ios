//
//  ViewController.swift
//  homework_2
//
//  Created by Никита on 09/03/2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    private var characters = [Character]() {
      didSet {
          DispatchQueue.main.async {
              self.tableView.reloadData()
          }
      }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        CharacterService.getCharacters { newCharacters in
            self.characters = newCharacters
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 128
        // Do any additional setup after loading the view.
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         characters.count
     }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath)
         guard let newCell = cell as? CharacterTableViewCell else { fatalError("Can not cast to cell type") }
         newCell.setup(character: characters[indexPath.row])
         return cell
     }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == characters.count - 1 else { return }
        CharacterService.getCharacters { characters in
            self.characters.append(contentsOf: characters)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "CharacterDetailViewController") as? DescriptionViewController else { return }
        viewController.setCharacter(character: characters[indexPath.row])
        navigationController?.pushViewController(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
