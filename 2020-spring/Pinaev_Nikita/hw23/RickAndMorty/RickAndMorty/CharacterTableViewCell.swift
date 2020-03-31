//
//  CharacterTableViewCell.swift
//  RickAndMorty
//
//  Created by Nikita Pinaev on 17.03.2020.
//  Copyright © 2020 Nikita Pinaev. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    @IBOutlet var label: UILabel!
    @IBOutlet var avatarImageView: UIImageView!
    private var avatarLoadTask: URLSessionTask?

    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        avatarLoadTask?.cancel()
    }

    func setup(with character: Character) {
        label.text = character.name
        guard let imageUrl = character.imageUrl else { return }
        avatarLoadTask = URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
                   guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.avatarImageView.image = image
            }
        }
        avatarLoadTask?.resume()
    }
}
