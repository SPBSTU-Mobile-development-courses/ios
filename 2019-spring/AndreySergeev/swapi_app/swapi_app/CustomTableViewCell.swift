//
//  CustomTableViewCell.swift
//  swapi_app
//
//  Created by Andrew on 27/04/2019.
//  Copyright © 2019 SPbSTU. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet private var avatar: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var genderLabel: UILabel!
    
    public func setAvatar(img: String) {
        avatar.image = UIImage(named: img)
    }
    
    public func setNameLabel(name: String) {
        nameLabel.text = name
    }
    
    public func setGenderLabel(gender: String) {
        genderLabel.text = gender
    }
}
