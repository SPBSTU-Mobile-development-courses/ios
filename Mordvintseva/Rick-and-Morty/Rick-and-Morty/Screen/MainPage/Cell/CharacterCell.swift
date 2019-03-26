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
        //print(imageURL)
        nameLabel.text = name
        avatar.getImageByURL(url: imageURL, size: CGSize(width: avatar.frame.width, height: avatar.frame.height))
    }

    func resizeImage(image: UIImage, width: CGFloat, height: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), true, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))

        print(image)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
