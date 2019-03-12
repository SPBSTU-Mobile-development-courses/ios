//
//  ViewController.swift
//  StarWarsWiki
//
//  Created by Виталий on 09.03.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import UIKit

class FilmsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var filmTableView: UITableView!
    private var films: [Film] = []
    private var netService: FilmServiceNetwork!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filmTableView.delegate = self
        self.filmTableView.dataSource = self
        self.netService = FilmServiceNetwork()
        loadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueShowInfo" {
            let controller = segue.destination as? InfoFilmTableViewController
            controller?.film = films[(sender as? UIButton)?.tag ?? 0]
        }
    }
    // Download film data and reload tableView
    func loadData() {
        self.netService.getData() { films in
            self.films += films
            DispatchQueue.main.async {
                self.filmTableView.reloadData()
            }
        }
    }
    // MARK: protocol's methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = self.films.count - 1
        if indexPath.row == lastItem {
            self.netService.page += 1
            loadData()
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Film") as? FilmTableViewCell
        let film = films[indexPath.row]
        cell?.set(info: film, withIndex: indexPath.row)
        return cell!
    }
}
