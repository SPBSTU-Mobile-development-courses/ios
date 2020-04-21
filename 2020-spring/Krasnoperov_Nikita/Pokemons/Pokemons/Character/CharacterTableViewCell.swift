//
//  CharacterTableViewCell.swift
//  homework_2
//
//  Created by Никита on 10/03/2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Kingfisher
import UIKit

class CharacterTableViewCell: UITableViewCell {
    @IBOutlet private var label: UILabel!
    @IBOutlet private var picture: UIImageView!

    override func prepareForReuse() {
       super.prepareForReuse()
        picture.image = nil
        picture.kf.cancelDownloadTask()
    }
    func setup(character: Character) {
        label.text = character.name
         CharacterService.getCharacterDescription(character: character) { characterDescription in
            guard let characterDescription = characterDescription else { return }
            guard let url = URL(string: characterDescription.sprites.front_default) else { return }
            self.picture.kf.setImage(with: url)
         }
    }
}
