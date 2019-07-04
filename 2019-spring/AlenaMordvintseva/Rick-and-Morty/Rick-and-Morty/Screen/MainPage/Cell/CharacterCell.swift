//
//  Cell.swift
//  Rick-and-Morty
//
//  Created by Mordvintseva Alena on 19/03/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import UIKit

class CharacterCell: UITableViewCell {
    @IBOutlet private var avatar: UIImageView!
    @IBOutlet private var nameLabel: UILabel!

    func set(name: String, imageURL: String) {
        guard let imageURL = URL(string: imageURL) else { return }
        nameLabel.text = name
        avatar.getImageByURL(url: imageURL)
    }
}
