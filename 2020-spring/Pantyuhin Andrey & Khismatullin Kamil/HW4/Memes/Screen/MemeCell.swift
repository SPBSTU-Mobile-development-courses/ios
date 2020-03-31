//
//  MemeCell.swift
//  Memes
//
//  Created by panandafog on 20.03.2020.
//  Copyright © 2020 panandafog. All rights reserved.
//

import Kingfisher
import UIKit

class MemeCell: UITableViewCell {
    @IBOutlet private var label: UILabel!
    @IBOutlet private var picture: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
        picture.image = nil
        picture.kf.cancelDownloadTask()
    }

    func setup(with meme: Post) {
        label.text = meme.title
        guard let url = meme.images?[0].url else { return }
        picture.kf.setImage(with: url)
    }
}
