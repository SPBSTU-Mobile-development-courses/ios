//
//  ViewController.swift
//  Rick-and-Morty
//
//  Created by Mordvintseva Alena on 17/03/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import Alamofire
import RealmSwift
import UIKit

class MainPageController: UIViewController, UITableViewDelegate {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var loadingView: UIActivityIndicatorView!
    private let dataBase = DBManager()
    private lazy var characters = dataBase.getAll()
    private var nextPageURL: String? = "https://rickandmortyapi.com/api/character/"
    private let cellIdentifier = "cell"
    private let characterService = CharacterServiceNetwork()
    private var networkIsReachable: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        if let reachable = NetworkReachabilityManager()?.isReachable {
            networkIsReachable = reachable
        }

        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "CharacterCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: cellIdentifier)

        print("Database size \(characters.count)")
        if networkIsReachable, characters.isEmpty {
            print("Starting loading info")
            loadAllCharacters()
        } else if !networkIsReachable {
            print("No network connection")
        }
    }

    func loadAllCharacters() {
        guard let nextPage = nextPageURL else {
            return
        }

        tableView.tableFooterView = loadingView
        characterService.getCharacters(url: nextPage) { charactersData in
            charactersData.results.forEach {
                self.dataBase.add($0)
            }
            self.nextPageURL = charactersData.info.next
            DispatchQueue.main.async {
                self.tableView.tableFooterView = UIView()
                self.tableView.reloadData()
            }
        }
    }
}

extension MainPageController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            as? CharacterCell else {
            fatalError("Cell cannot be displayed")
        }

        cell.set(name: self.characters[indexPath.row].name, imageURL: self.characters[indexPath.row].image)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let characterController = storyboard?.instantiateViewController(withIdentifier: "CharacterView")
            as? CharacterViewController else { return }
        self.navigationController?.pushViewController(characterController, animated: true)
        characterController.setCharacter(character: characters[indexPath.row])
    }
}
