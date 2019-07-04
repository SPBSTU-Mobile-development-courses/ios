//
//  ViewController.swift
//  StarWarsWiki
//
//  Created by Виталий on 09.03.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import UIKit

class FilmsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet private var filmTableView: UITableView!
    private var films: [Film] = []
    private let filmService = FilmServiceNetwork()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filmTableView.delegate = self
        self.filmTableView.dataSource = self
        loadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "segueShowInfo" else { return }
        let controller = segue.destination as? InfoFilmTableViewController
        // swiftlint:disable force_unwrapping
        controller?.set(film: films[((sender as? UIButton)?.tag)!])
        // swiftlint:enable force_unwrapping
    }
    
    func loadData() {
        self.filmService.getData { [unowned self] films in
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
        if indexPath.row == (self.films.count - 1) {
            loadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Film") as? FilmTableViewCell else {
            return tableView.dequeueReusableCell(withIdentifier: "Film", for: indexPath)
        }
        let film = films[indexPath.row]
        cell.set(info: film, withIndex: indexPath.row)
        return cell
    }
}
