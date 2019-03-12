//
//  ActorsCollectionViewCell.swift
//  StarWarsWiki
//
//  Created by Виталий on 11.03.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import UIKit

class ActorsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var actorNameLabel: UILabel!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterView: UIView!
    @IBOutlet weak var backgroundCharacterView: UIView!
    //set values for class properties with actor's values
    func set(actor: Actor) {
        self.actorNameLabel.text = actor.name! + ":"
        self.characterNameLabel.text = actor.character!
        self.backgroundCharacterView.layer.cornerRadius = 8.0
        self.backgroundCharacterView.clipsToBounds = true
        self.characterView.layer.cornerRadius = 8.0
        self.characterView.clipsToBounds = true
    }
}
