//
//  CardDetailController.swift
//  Mtg Cards
//
//  Created by alexander on 08.03.2020.
//  Copyright © 2020 alexander. All rights reserved.
//
import Reusable
import UIKit

final class CardDetailViewController: UIViewController, StoryboardBased {
    var card: Card?
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var cardImageView: UIImageView!
    @IBOutlet private var flavourTextLabel: UILabel!
    @IBOutlet private var artistLabel: UILabel!
    @IBOutlet private var rarityLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let card = card else {
            return
        }
        title = "\(card.name)  card details"
        nameLabel.text = "Name: \(card.name)"
        flavourTextLabel.text = "Flavor text: \(card.flavorText ?? "")"
        flavourTextLabel.sizeToFit()
        artistLabel.text = "Artist: \(card.artist ?? "")"
        rarityLabel.text = "Rarity: \(card.rarity)"
        guard let imageURL = URL(string: card.imageUris?.normal ?? "") else {
            return
        }
        let cardLoadTask = URLSession.shared.dataTask(with: imageURL) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                self.cardImageView.image = image
            }
        }
        cardLoadTask.resume()
    }
}
