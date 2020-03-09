//
//  CardDetailController.swift
//  Mtg Cards
//
//  Created by alexander on 08.03.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import UIKit

final class CardDetailViewController : UIViewController{
    var card: Card?
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var cardImageView: UIImageView!
    @IBOutlet weak private var flavourTextLabel: UILabel!
    @IBOutlet weak private var artistLabel: UILabel!
    @IBOutlet weak private var rarityLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = (card?.name ?? "") + " card details"
        nameLabel.text = "Name: " + (card?.name ?? "")
        flavourTextLabel.text = "Flavor text: \n" + (card?.flavor_text ?? "")
        flavourTextLabel.sizeToFit()
        artistLabel.text = "Artist: " + (card?.artist ?? "")
        rarityLabel.text = "Rarity: " + (card?.rarity ?? "")
        guard let imageURL = URL(string: card?.image_uris?.normal ?? "") else {
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
