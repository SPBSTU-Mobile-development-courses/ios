//
//  InfoFilmTableViewController.swift
//  StarWarsWiki
//
//  Created by Виталий on 11.03.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import UIKit

class InfoFilmTableViewController: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var actorsCollectionView: UICollectionView!
    var actors: [Actor] = []
    var film: Film!
    var netService = CreditsServiceNetwork()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = film.title
        self.dateLabel.text = film.releaseDate
        self.ratingLabel.text = "\(film.rating!)"
        self.descriptionTextView.text = film.description
        self.netService.movieId = film.id!
        self.actorsCollectionView.delegate = self
        self.actorsCollectionView.dataSource = self
        loadData()
    }
    // Download film data and reload tableView
    func loadData() {
        self.netService.getData() { actors in
            self.actors += actors
            DispatchQueue.main.async {
                self.actorsCollectionView.reloadData()
            }
        }
    }
    // MARK: protocol's methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let destViewController = storyboard.instantiateViewController(withIdentifier: "ActorWebViewController") as? ActorWebViewController
        destViewController?.actorName = actors[indexPath.row].name!
        self.navigationController?.pushViewController(destViewController!, animated: true)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.actors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Actor", for: indexPath) as? ActorsCollectionViewCell
        cell?.set(actor: actors[indexPath.row])
        return cell!
    }
}
