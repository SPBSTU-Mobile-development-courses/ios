//
//  CharacterDataViewController.swift
//  RickAndMorty
//
//  Created by Nikita Pinaev on 30.03.2020.
//  Copyright © 2020 Nikita Pinaev. All rights reserved.
//

import UIKit

final class CharacterDetailViewController: UIViewController {
    var character: Character?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(character ?? "No character")
    }
}
