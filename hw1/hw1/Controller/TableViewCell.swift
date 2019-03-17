//
//  TableViewCell.swift
//  hw1
//
//  Created by Александр Пономарёв on 13/03/2019.
//  Copyright © 2019 Александр Пономарёв. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var avatarView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        avatarView.layer.cornerRadius = avatarView.frame.size.width / 2
        avatarView.clipsToBounds = true
    }
    
    func setupCell(person: Person, image: UIImage) {
        nameLabel.text = person.name
        avatarView.image = image
    }
}
