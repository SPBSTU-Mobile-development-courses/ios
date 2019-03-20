//
//  TableViewCell.swift
//  hw1
//
//  Created by Александр Пономарёв on 13/03/2019.
//  Copyright © 2019 Александр Пономарёв. All rights reserved.
//

import Kingfisher
import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var avatarView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        avatarView.layer.cornerRadius = avatarView.frame.size.width / 2
        avatarView.clipsToBounds = true
    }

    func setupCell(name: String, imageURL: String) {
        let imgURL = URL(string: imageURL)
        nameLabel.text = name
        avatarView.kf.setImage(with: imgURL)
    }
}
