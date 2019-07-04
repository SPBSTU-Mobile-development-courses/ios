//
//  ViewController.swift
//  hw1
//
//  Created by Александр Пономарёв on 12/03/2019.
//  Copyright © 2019 Александр Пономарёв. All rights reserved.
//

import Kingfisher
import Reachability
import RealmSwift
import UIKit

class ViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    private let jsonDataService = JsonDataService()
    private let realmService = RealmService()
    private lazy var realmPerson = realmService.getAll()
    private let url: String? = "https://rickandmortyapi.com/api/character/"
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    private let reuseIdentifier = "Cell"
    //swiftlint:disable:next force_unwrapping
    private let reachability = Reachability()!
    private let search = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        self.navigationController?.navigationBar.prefersLargeTitles = true
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type character's name"
        self.navigationItem.searchController = search
        checkNetworkConnect()
        tableView.register(UINib(nibName: "TestTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        guard let url = url, realmPerson.isEmpty else { return }
        self.jsonDataService.getCharacter(url: url) { [weak self] characters, _ in
            guard let self = self else { return }
            self.realmService.addAll(people: characters)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    func checkNetworkConnect() {
        if realmPerson.isEmpty {
            reachability.whenUnreachable = { [weak self] _ in
                guard let self = self else { return }
                let alertController = UIAlertController(
                    title: "Mobile Data is Turned Off",
                    message: "Turn on mobile data or use Wi-Fi to access data",
                    preferredStyle: .alert
                )
                let cancelAction = UIAlertAction(title: "OK", style: .cancel)
                let settingAction = UIAlertAction(title: "Settings", style: .default) { _ -> Void in
                    guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
                    if UIApplication.shared.canOpenURL(settingsURL) { UIApplication.shared.open(settingsURL) }
                }
                alertController.addAction(settingAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true)
            }
            do {
                try reachability.startNotifier()
            } catch {
                print("Unable to start notifier")
            }
        }
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            realmPerson = realmService.getAll()
            tableView.reloadData()
            return
        }
        guard let itemFound = realmService.searchElement(name: "\(text)") else { return }
        realmPerson = itemFound
        tableView.reloadData()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? TestTableViewCell else {
            fatalError("TableView setup is not correct!")
        }
        let realmPeople = realmPerson[indexPath.row]
        cell.setupCell(with: realmPeople)
        return cell
    }
}
