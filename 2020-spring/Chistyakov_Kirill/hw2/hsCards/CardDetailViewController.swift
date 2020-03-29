//
//  CardDetailViewController.swift
//  hsCards
//
//  Created by Kirill Chistyakov on 28.03.2020.
//  Copyright © 2020 Kirill Chistyakov. All rights reserved.
//

import UIKit

final class CardDetailViewController: UIViewController {
    var card: Card?
    var image: UIImage?

    @IBOutlet private var detailImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var flavorLabel: UILabel!
    @IBOutlet private var artistNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg.jpg")!)
        guard let card = card else { return }
        detailImageView.image = image
        nameLabel.text = card.name
        flavorLabel.text = card.flavorText
        artistNameLabel.text = card.artistName
    }
}
