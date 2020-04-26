//
//  DescriptionViewController.swift
//  homework_2
//
//  Created by Никита on 12/04/2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {
    @IBOutlet private var frontPicture: UIImageView!
    @IBOutlet private var backPicture: UIImageView!
    private var character: Character?

    func setCharacter(character: Character?) {
        self.character = character
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let character = character else { return }
        CharacterService.getCharacterDescription(character: character) { characterDescription in
            guard let characterDescription = characterDescription else { return }
            guard let urlFront = URL(string: characterDescription.sprites.front_default) else { return }
            guard let urlBack = URL(string: characterDescription.sprites.back_default) else { return }
            DispatchQueue.main.async {
                self.frontPicture.kf.setImage(with: urlFront)
                self.backPicture.kf.setImage(with: urlBack)
            }
        }
    }
}
