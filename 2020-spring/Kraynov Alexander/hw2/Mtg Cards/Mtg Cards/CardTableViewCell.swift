//
//  CardTableViewCell.swift
//  Mtg Cards
//
//  Created by alexander on 07.03.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import UIKit
import Reusable

final class CardTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var cardImageView: UIImageView!
    private var cardLoadTask: URLSessionTask?
    override func prepareForReuse() {
        super.prepareForReuse()
        cardImageView.image = nil
        cardLoadTask?.cancel()
    }

    func setup(with card: Card) {
        nameLabel.text = card.name
        guard let imageURL = URL(string: card.imageUris?.normal ?? "") else {
            return
        }
        cardLoadTask = URLSession.shared.dataTask(with: imageURL) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                self.cardImageView.image = image
            }
        }
        cardLoadTask?.resume()
    }
}
