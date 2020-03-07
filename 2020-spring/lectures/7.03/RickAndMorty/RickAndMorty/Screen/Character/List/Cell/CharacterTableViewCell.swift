//
//  CharacterTableViewCell.swift
//  RickAndMorty
//
//  Created by Anton Nazarov on 06.03.2020.
//  Copyright © 2020 Anton Nazarov. All rights reserved.
//

import UIKit

final class CharacterTableViewCell: UITableViewCell {
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var avatarImageView: UIImageView!
    private var avatarLoadTask: URLSessionTask?

    override func prepareForReuse() {
        super.prepareForReuse()
        avatarLoadTask?.cancel()
    }

    func setup(with character: Character) {
        nameLabel.text = character.name
        avatarImageView.image = nil
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
