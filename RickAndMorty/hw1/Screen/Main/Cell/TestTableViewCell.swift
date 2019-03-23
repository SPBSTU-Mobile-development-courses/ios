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

    func setupCell(name: String, imageURL: String) {
        let imgURL = URL(string: imageURL)
        nameLabel.text = name
        self.avatarView.kf.setImage(with: imgURL)
    }
}
