//
//  ActorsCollectionViewCell.swift
//  StarWarsWiki
//
//  Created by Виталий on 11.03.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Reusable
import UIKit

class ActorsCollectionViewCell: UICollectionViewCell, Reusable {
    @IBOutlet private var actorNameLabel: UILabel!
    @IBOutlet private var characterNameLabel: UILabel!
    @IBOutlet private var characterView: UIView!
    @IBOutlet private var backgroundCharacterView: UIView!

    func set(actor: Actor) {
        self.actorNameLabel.text = actor.name + ":"
        self.characterNameLabel.text = actor.character
        self.backgroundCharacterView.layer.cornerRadius = 8.0
        self.backgroundCharacterView.clipsToBounds = true
        self.characterView.layer.cornerRadius = 8.0
        self.characterView.clipsToBounds = true
    }
}
