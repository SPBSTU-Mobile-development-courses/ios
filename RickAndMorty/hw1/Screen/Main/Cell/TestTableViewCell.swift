//
//  TestTableViewCell.swift
//  hw1
//
//  Created by Александр Пономарёв on 21/03/2019.
//  Copyright © 2019 Александр Пономарёв. All rights reserved.
//

import UIKit

class TestTableViewCell: UITableViewCell {
    @IBOutlet private var avatarView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        avatarView.layer.borderWidth = 1
        avatarView.layer.masksToBounds = false
        avatarView.layer.borderColor = UIColor.black.cgColor
        avatarView.layer.cornerRadius = avatarView.frame.height / 2
        avatarView.clipsToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        avatarView.kf.cancelDownloadTask()
    }

    func setupCell(with person: RealmChar) {
        nameLabel.text = person.name
        self.avatarView.kf.indicatorType = .activity
        self.avatarView.kf.setImage(with: person.imageUrl)
    }
}
