//
//  InfoFilmTableViewController.swift
//  StarWarsWiki
//
//  Created by Виталий on 11.03.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Reusable
import UIKit

class InfoFilmTableViewController: UITableViewController {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var ratingLabel: UILabel!
    @IBOutlet private var descriptionTextView: UITextView!
    @IBOutlet private var actorsCollectionView: UICollectionView!
    @IBOutlet private var actorsCollectionHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var errorActorLoadLabel: UILabel!
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var infoFilmViewModel: InfoFilmViewModelProtocol!
    private var actors = [Actor]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                 self?.actorsCollectionView.reloadData()
            }
        }
    }
    var film: Film? {
        didSet {
            guard let film = film else { return }
            infoFilmViewModel = InfoFilmViewModel(infoFilmService: CreditsServiceNetwork(withMovieId: film.id))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = film?.title
        dateLabel.text = film?.releaseDate
        ratingLabel.text = "\(film?.voteAverage ?? 0)"
        descriptionTextView.text = film?.overview
        infoFilmViewModel.onActorsNotUploaded = { [weak self] in
            self?.actorsCollectionHeightConstraint.constant = 0
            self?.errorActorLoadLabel.isHidden = false
        }
        infoFilmViewModel?.onActorsChanged = { [weak self] actors in
            self?.actors = actors
        }
        infoFilmViewModel?.loadMore()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: UICollectionViewDataSource
extension InfoFilmTableViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as ActorsCollectionViewCell
        cell.set(actor: actors[indexPath.row])
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension InfoFilmTableViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let actorViewController = ActorWebViewController.instantiate()
        actorViewController.actorName = actors[indexPath.row].name
        navigationController?.pushViewController(actorViewController, animated: true)
    }
}

// MARK: StoryboardSceneBased
extension InfoFilmTableViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard {
        return UIStoryboard(name: "FilmInfo", bundle: nil)
    }
}
