//
//  CharacterTableViewCell.swift
//  RickAndMorty
//
//  Created by user on 22.04.2020.
//  Copyright © 2020 ulkoart. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    @IBOutlet private var label: UILabel!
    @IBOutlet private var characterImage: UIImageView!
    private var avatarLoadTask: URLSessionTask?

    override func prepareForReuse() {
        super.prepareForReuse()
        characterImage.image = nil
        avatarLoadTask?.cancel()
    }

    func setup(with character: Character) {
        label.text = Array(repeating: character.name, count: 1).joined()
        guard let imageUrl = URL(string: character.image) else { return }
        avatarLoadTask = URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.characterImage.image = image
            }
        }
        avatarLoadTask?.resume()
    }

}
