//
//  FilmTableViewCell.swift
//  StarWarsWiki
//
//  Created by Виталий on 10.03.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import SDWebImage
import UIKit

class FilmTableViewCell: UITableViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var shortDescriptionTextView: UILabel!
    @IBOutlet weak var moreInfoButton: UIButton!
    // set values for class properties with film's values and
    // cell's number
    func set(info film: Film, withIndex index: Int) {
        self.posterImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(film.posterPath!)"), placeholderImage: UIImage(named: "placeholder.png"))
        self.posterImageView.layer.cornerRadius = 8.0
        self.posterImageView.clipsToBounds = true
        self.titleLabel.text = film.title!
        self.shortDescriptionTextView.text = film.description ?? "No description"
        self.moreInfoButton.layer.cornerRadius = 8.0
        self.moreInfoButton.clipsToBounds = true
        self.moreInfoButton.tag = index
    }
}
