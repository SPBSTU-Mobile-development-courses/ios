//
//  DetailVC.swift
//  RickAndMorty
//
//  Created by user on 22.04.2020.
//  Copyright © 2020 ulkoart. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    

    @IBOutlet weak var characterLabel: UILabel!
    var character: Character!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterLabel.text = "\(character.name) - \(character.status)"
    }


}
