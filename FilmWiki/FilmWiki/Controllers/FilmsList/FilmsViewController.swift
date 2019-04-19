//
//  ViewController.swift
//  StarWarsWiki
//
//  Created by Виталий on 09.03.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Reusable
import UIKit

class FilmsViewController: UIViewController {
    private enum Const {
        static let cellIdentifier = "FilmCell"
    }
    @IBOutlet private var filmTableView: UITableView!
    private var filmListViewModel = FilmViewModel(filmService: FilmServiceNetwork())
    private var films = [Film]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.filmTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filmListViewModel.onFilmsChanged = { [weak self] films in
            guard let self = self else { return }
            self.films += films
        }
        filmListViewModel.loadMore()
    }
    
    @IBAction private func getMoreFilmInfo(_ sender: UIButton) {
        let detailViewController = InfoFilmTableViewController.instantiate()
        detailViewController.film = films[sender.tag]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: UITableViewDataSource
extension FilmsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Const.cellIdentifier, for: indexPath) as? FilmTableViewCell else {
            fatalError("TableView setup is not correct")
        }
        let film = films[indexPath.row]
        cell.set(info: film, withIndex: indexPath.row)
        return cell
    }
}

// MARK: UITableViewDelegate
extension FilmsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (films.count - 1) {
            filmListViewModel.loadMore()
        }
    }
}

// MARK: StoryboardSceneBased
extension FilmsViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}
