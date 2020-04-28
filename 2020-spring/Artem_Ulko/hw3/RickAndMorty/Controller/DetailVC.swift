//
//  DetailVC.swift
//  RickAndMorty
//
//  Created by user on 22.04.2020.
//  Copyright © 2020 ulkoart. All rights reserved.
//

import Kingfisher
import UIKit

class DetailVC: UIViewController {
    @IBOutlet private var characterLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    var character: Character?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCharacter()

    }

    private func setUpCharacter () {
        guard let character = character  else { return }

        let imageUrl = URL(string: character.image)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: imageUrl)
        characterLabel.text = "\(character.name) - \(character.status)"

    }
}
