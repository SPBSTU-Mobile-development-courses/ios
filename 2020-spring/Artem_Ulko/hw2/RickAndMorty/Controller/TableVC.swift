//
//  ViewController.swift
//  RickAndMorty
//
//  Created by user on 22.04.2020.
//  Copyright © 2020 ulkoart. All rights reserved.
//

import UIKit

class TableVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let characterService = CharacterService()
    var characters = [Character]()
    var selectedCharacter:Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 128
        
        characterService.getCharacters { characters in
            guard let characters = characters else { return }
            self.characters = characters
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension TableVC: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as! CharacterTableViewCell

        let character: Character = characters[indexPath.row]
        cell.setup(with: character)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == characters.count - 1 else {
            return
        }
        
        characterService.getMoreCharacters { characters in
            guard let characters = characters else { return }
            self.characters.append(contentsOf: characters)

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character: Character = characters[indexPath.row]
        selectedCharacter = character
        performSegue(withIdentifier: "ShowDetail", sender: (Any).self)
        
    }
}

extension TableVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let detail = segue.destination as! DetailVC
            detail.character = selectedCharacter
        }
    }
}
