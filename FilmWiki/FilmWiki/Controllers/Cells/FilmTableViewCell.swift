//
//  FilmTableViewCell.swift
//  StarWarsWiki
//
//  Created by Виталий on 10.03.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Kingfisher
import Reusable
import UIKit

class FilmTableViewCell: UITableViewCell, NibReusable {
    private enum Const {
        static let posterURL = "https://image.tmdb.org/t/p/w500"
    }
    @IBOutlet private var posterImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var shortDescriptionLabel: UILabel!
    @IBOutlet private var moreInfoButton: UIButton!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.kf.cancelDownloadTask()
    }
    
    func set(info film: Film, withIndex index: Int) {
        if let posterPath = film.posterPath {
            self.posterImageView.kf.setImage(with: URL(string: Const.posterURL + posterPath))
        }
        self.posterImageView.layer.cornerRadius = 8.0
        self.posterImageView.clipsToBounds = true
        self.titleLabel.text = film.title
        self.shortDescriptionLabel.text = film.overview
        self.shortDescriptionLabel.sizeToFit()
        self.moreInfoButton.layer.cornerRadius = 8.0
        self.moreInfoButton.clipsToBounds = true
        self.moreInfoButton.tag = index
    }
}
