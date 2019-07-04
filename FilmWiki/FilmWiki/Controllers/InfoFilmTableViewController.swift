//
//  InfoFilmTableViewController.swift
//  StarWarsWiki
//
//  Created by Виталий on 11.03.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import UIKit

class InfoFilmTableViewController: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var ratingLabel: UILabel!
    @IBOutlet private var descriptionTextView: UITextView!
    @IBOutlet private var actorsCollectionView: UICollectionView!
    private var actors: [Actor] = []
    // swiftlint:disable implicitly_unwrapped_optional
    private var film: Film!
    // swiftlint:enable implicitly_unwrapped_optional
    private var infoFilmService = CreditsServiceNetwork()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = film.title
        self.dateLabel.text = film.releaseDate
        self.ratingLabel.text = "\(film.rating)"
        self.descriptionTextView.text = film.description
        self.infoFilmService.movieId = film.id
        self.actorsCollectionView.delegate = self
        self.actorsCollectionView.dataSource = self
        loadData()
    }
    
    func set(film: Film) {
        self.film = film
    }
    
    func loadData() {
        self.infoFilmService.getData { [unowned self] actors in
            self.actors += actors
            DispatchQueue.main.async {
                self.actorsCollectionView.reloadData()
            }
        }
    }
    
    // MARK: protocol's methods
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 4 {
            return self.actorsCollectionView.frame.height + 40
        }
        return UITableView.automaticDimension
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destViewController = storyboard.instantiateViewController(withIdentifier: "ActorWebViewController") as? ActorWebViewController else { return }
        destViewController.set(actorName: actors[indexPath.row].name)
        self.navigationController?.pushViewController(destViewController, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.actors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Actor", for: indexPath) as? ActorsCollectionViewCell else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "Actor", for: indexPath)
        }
        cell.set(actor: actors[indexPath.row])
        return cell
    }
}
