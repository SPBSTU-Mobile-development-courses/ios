//
//  MemeCell.swift
//  HW2
//
//  Created by panandafog on 20.03.2020.
//  Copyright © 2020 panandafog. All rights reserved.
//

import UIKit

class MemeCell: UITableViewCell {
    @IBOutlet var label: UILabel!
    @IBOutlet var picture: UIImageView!
    private var avatarLoadTask: URLSessionTask?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        picture.image = nil
        avatarLoadTask?.cancel()
    }
    
    func setup(with meme: Post) {
        label.text = meme.title
        guard let url = meme.images?[0].url else { return }
        avatarLoadTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.picture.image = image
            }
        }
        avatarLoadTask?.resume()
    }
}
