//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Anton Nazarov on 07.03.2020.
//  Copyright © 2020 Anton Nazarov. All rights reserved.
//

import UIKit

final class CharacterDetailViewController: UIViewController{
    var character: Character?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(character ?? "No character")
    }
}

