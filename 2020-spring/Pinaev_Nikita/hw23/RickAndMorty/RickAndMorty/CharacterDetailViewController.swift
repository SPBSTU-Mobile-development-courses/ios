//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Nikita Pinaev on 24.03.2020.
//  Copyright © 2020 Nikita Pinaev. All rights reserved.
//

import UIKit

final class CharacterDetailViewController: UIViewController {
    var character: Character!
    private var avatarLoadTask: URLSessionTask?
    @IBOutlet private var characterImage: UIImageView!
    @IBOutlet private var characterName: UILabel!
     @IBOutlet private var characterStatus: UILabel!
     @IBOutlet private var characterSpecies: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let character = self.character else {
            return
        }
        characterName.text = character.name
        characterStatus.text = character.status
        characterSpecies.text = character.species
        guard let imageUrl = URL(string: character.image ) else {return}
        avatarLoadTask = URLSession.shared.dataTask(with: imageUrl) {data, _, _ in
                guard let data = data, let image = UIImage(data: data) else {return}
                DispatchQueue.main.async {
                    self.characterImage.image = image
                }
            }
            avatarLoadTask?.resume()
        }
}
