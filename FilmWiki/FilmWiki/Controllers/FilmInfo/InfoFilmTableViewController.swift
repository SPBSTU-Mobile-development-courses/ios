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
    private enum Const {
        static let cellIdentifier = "ActorCell"
        static let bottomIndent: CGFloat = 40
    }
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var ratingLabel: UILabel!
    @IBOutlet private var descriptionTextView: UITextView!
    @IBOutlet private var actorsCollectionView: UICollectionView!
    private var infoFilmViewModel: InfoFilmViewModel<CreditsServiceNetwork>?
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
        ratingLabel.text = "\(film?.rating ?? 0)"
        descriptionTextView.text = film?.description
        infoFilmViewModel?.onActorsChanged = { [weak self] actors in
            self?.actors = actors
        }
        infoFilmViewModel?.loadMore()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 4 ? actorsCollectionView.frame.height + Const.bottomIndent : UITableView.automaticDimension
    }
}

// MARK: UICollectionViewDataSource
extension InfoFilmTableViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.actors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.cellIdentifier, for: indexPath) as? ActorsCollectionViewCell else {
            fatalError("TableView setup is not correct")
        }
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
