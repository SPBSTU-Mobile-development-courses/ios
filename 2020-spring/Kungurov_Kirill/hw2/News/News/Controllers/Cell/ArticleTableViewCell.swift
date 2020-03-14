//
//  ArticleTableViewCell.swift
//  News
//
//  Created by Kirill Kungurov on 14.03.2020.
//  Copyright © 2020 Kirill Kungurov. All rights reserved.
//

import Kingfisher
import UIKit

final class ArticleTableViewCell: UITableViewCell {
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var articleTitleLabel: UILabel!
    @IBOutlet private var articalImageView: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
        articalImageView.image = nil
        articalImageView.kf.cancelDownloadTask()
    }

    func setUp(with article: Article) {
        dateLabel.text = article.date
        articleTitleLabel.text = article.title
        articalImageView.kf.setImage(with: article.imageUrl)
    }
}
